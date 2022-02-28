Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8A4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 18:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbiB1SlU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240804AbiB1Sk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:40:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1FF559D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:34:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE5EF61518
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 18:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FC7C340E7;
        Mon, 28 Feb 2022 18:34:50 +0000 (UTC)
Date:   Mon, 28 Feb 2022 18:34:46 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Engraf <david.engraf@sysgo.com>
Cc:     suzuki.poulose@arm.com, will@kernel.org, broonie@kernel.org,
        mark.rutland@arm.com, elver@google.com, ebiederm@xmission.com,
        seanjc@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: signal: nofpsimd: Do not allocate fp/simd context
 when not available
Message-ID: <Yh0VxizGmOFHVqL3@arm.com>
References: <20220225104008.820289-1-david.engraf@sysgo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225104008.820289-1-david.engraf@sysgo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 11:40:08AM +0100, David Engraf wrote:
> Commit 6d502b6ba1b2 ("arm64: signal: nofpsimd: Handle fp/simd context for
> signal frames") introduced saving the fp/simd context for signal handling
> only when support is available. But setup_sigframe_layout() always
> reserves memory for fp/simd context. The additional memory is not touched
> because preserve_fpsimd_context() is not called and thus the magic is
> invalid.
> 
> This may lead to an error when parse_user_sigframe() checks the fp/simd
> area and does not find a valid magic number.
> 
> Signed-off-by: David Engraf <david.engraf@sysgo.com>

Given that it's not a regression, I wouldn't push it at -rc7. But if
Will picks it up for 5.18, I think it's worth adding:

Fixes: 6d502b6ba1b2 ("arm64: signal: nofpsimd: Handle fp/simd context for signal frames")
Cc: <stable@vger.kernel.org> # 5.6.x

With that:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

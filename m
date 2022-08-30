Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E14ECAAA1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 16:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiH3QlL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 12:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiH3QlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:41:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F8A9DB50
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:41:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90B7E6170C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCC8C433C1;
        Tue, 30 Aug 2022 16:41:03 +0000 (UTC)
Date:   Tue, 30 Aug 2022 17:40:59 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Levi Yun <ppbuk5246@gmail.com>
Cc:     bhe@redhat.com, will@kernel.org, nramas@linux.microsoft.com,
        thunder.leizhen@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v2] arm64/kexec: Fix missing extra range for
 crashkres_low.
Message-ID: <Yw49m7Hpq+NIZYWw@arm.com>
References: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
 <20220830092839.3197-1-ppbuk5246@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830092839.3197-1-ppbuk5246@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 06:28:39PM +0900, Levi Yun wrote:
> Like crashk_res, Calling crash_exclude_mem_range function with
> crashk_low_res area would need extra crash_mem range too.
> 
> Add one more extra cmem range slot in case of crashk_low_res is used.
> 
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Does this need a Fixes tag and cc stable?

-- 
Catalin

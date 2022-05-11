Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B94EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 16:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344418AbiEKQL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 12:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344434AbiEKQLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:11:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE826440
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:11:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FAD061BDD
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9A1C3411B;
        Wed, 11 May 2022 16:11:00 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     maz@kernel.org, will@kernel.org,
        Linu Cherian <lcherian@marvell.com>
Cc:     linuc.decode@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V2] arm64: Declare non global symbols as static
Date:   Wed, 11 May 2022 17:10:58 +0100
Message-Id: <165228543800.1284917.17676885885989529216.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220509043221.16361-1-lcherian@marvell.com>
References: <20220509043221.16361-1-lcherian@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2022 10:02:21 +0530, Linu Cherian wrote:
> Fix below sparse warnings introduced while adding errata.
> 
> arch/arm64/kernel/cpu_errata.c:218:25: sparse: warning: symbol
> 'cavium_erratum_23154_cpus' was not declared. Should it be static?
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Declare non global symbols as static
      https://git.kernel.org/arm64/c/710c8d6c026c

-- 
Catalin


Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C87C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 16:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383143AbiBHQWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 11:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354546AbiBHQWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:22:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E5CC0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:22:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7CBB616D4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 16:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA85C340E9;
        Tue,  8 Feb 2022 16:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644337333;
        bh=MejpiH0diIFxacygh8l6EcAFhF9ZPTI/1saRrB4FEHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C3WubjhTrezZEmOoDNOWDkqOhjIIkSEZxvmA73rQzLCtBhiePAR2kA1dryjSJVYBe
         NWjwkPH3Af4gTZvROlC8XGmMAafkCX4QgEzauAO1ftCegAqnSr5KkiK5iHGl4TAhaY
         YdU6zmsr98mqhbZp16LUFhkD3JVo7xEGBIYjFkF2Ggc1rZgAqDVEuw8l1IbPwMBN/i
         jTdh1fFWY6jKI/BFGMSm4VE9oR7y7nztfxp4vsbYi9QojgsakO/29QEqGk9eXIeV1L
         SBF85MJzqqtxBdt6iOHR6jHbFIyk0ksFJCilG9axZhOx47m2ZJFXk9yVIuNY0dP5dU
         wdxVd/a80nWHg==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        iommu@lists.linux-foundation.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, xuqiang36@huawei.com,
        jean-philippe@linaro.org, joro@8bytes.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: fix event handling soft lockup
Date:   Tue,  8 Feb 2022 16:21:56 +0000
Message-Id: <164433646915.1069624.13877694890558987574.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220119070754.26528-1-zhouguanghui1@huawei.com>
References: <20220119070754.26528-1-zhouguanghui1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 07:07:54 +0000, Zhou Guanghui wrote:
> During event processing, events are read from the event queue one
> by one until the queue is empty.If the master device continuously
> requests address access at the same time and the SMMU generates
> events, the cyclic processing of the event takes a long time and
> softlockup warnings may be reported.
> 
> arm-smmu-v3 arm-smmu-v3.34.auto: event 0x0a received:
> arm-smmu-v3 arm-smmu-v3.34.auto: 	0x00007f220000280a
> arm-smmu-v3 arm-smmu-v3.34.auto: 	0x000010000000007e
> arm-smmu-v3 arm-smmu-v3.34.auto: 	0x00000000034e8670
> watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [irq/268-arm-smm:247]
> Call trace:
>  _dev_info+0x7c/0xa0
>  arm_smmu_evtq_thread+0x1c0/0x230
>  irq_thread_fn+0x30/0x80
>  irq_thread+0x128/0x210
>  kthread+0x134/0x138
>  ret_from_fork+0x10/0x1c
> Kernel panic - not syncing: softlockup: hung tasks
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: fix event handling soft lockup
      https://git.kernel.org/will/c/30de2b541af9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

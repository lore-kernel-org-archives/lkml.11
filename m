Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B35C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 17:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbiGSRoR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 13:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiGSRoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:44:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311A255089
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:44:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDB446168C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 17:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98344C341C6;
        Tue, 19 Jul 2022 17:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658252643;
        bh=XvMJP/gyOj9tpLNhHTh9VPOCWAevdFiwah/LQhNP0Uo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=r14b3l2+VKNrwMqZwxfSffgTihmJos+jbTKbF1331z/AL4QO6Lr8SglBvZi2IB78r
         Iqi/rhMA8XIUiaVXlprdHPREvxnKfUNH9OdXf4OwALmOEdbfVzO5QKfhMpel3ypN85
         4kfvjapaMq9pUAPc3fPOgCJ6hlNGuxld4cgPmjQTtvQjDmCzsmy2SYcPvs1l+gULwI
         xdAak2EoNo/UivuUqxbdzY5YgNNBjH3UExJPXCE10wbbQBD/6uzJqtNOe7tKvTc761
         PD4mCi9lesblFelMfv8JeLR8X0b7oVq6IJBP03fNtNQxoD2deJXxaeCdPMEP+efPuO
         kWKl90uJJ5aCA==
From:   Mark Brown <broonie@kernel.org>
To:     mario.limonciello@amd.com, Vijendar.Mukunda@amd.com
Cc:     perex@perex.cz, alsa-devel@alsa-project.org, tiwai@suse.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220718213402.19497-1-mario.limonciello@amd.com>
References: <20220718213402.19497-1-mario.limonciello@amd.com>
Subject: Re: [PATCH] ASoC: amd: yc: Decrease level of error message
Message-Id: <165825264132.406155.16263788665685551541.b4-ty@kernel.org>
Date:   Tue, 19 Jul 2022 18:44:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 16:34:02 -0500, Mario Limonciello wrote:
> On a number of platforms that contain acp3x controller a new ERR level
> message is showing up:
> 
> `acp6x pci device not found`
> 
> This is because ACP3x and ACP6x share same PCI ID but can be identified
> by PCI revision.  As this is expected behavior for a system with ACP3x
> decrease message to debug.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Decrease level of error message
      commit: 393a40b50fe976a121b15752d2dd6151c7a92126

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

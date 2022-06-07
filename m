Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202E8C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 10:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241491AbiFGKpz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 06:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241521AbiFGKpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:45:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1DFED7A2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:45:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9514261552
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D83C385A5;
        Tue,  7 Jun 2022 10:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598734;
        bh=39oGiysk6PLHAMAwWPILJB+GlGqroBrBPZj4jX62IB4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=o94csVCXA+OwXNOQeRM+Bvnmap9v9MZ0rAAiHeWFL1aM57kgBrU8rl+uGc18tGsvV
         OftBZx5fImxQ8t3sK67imRGgDrbACv+1tfNjFJSYZQH75lX2K6zpSodINglcz8RvU+
         y/BDNnbQDVXBW+QLi8d6t9QHec23sag2Grd2XBIw5vX7JH8NREmorK7FZojhhpggmM
         sYpNTxGyyCn+sMbmOMuKkxPNZ8HuqI5Vg8RorUAYmxHJt7CDoEPTec9+M9s9ai9IJ4
         RSQIKbGzd0MiKsd3VajiCxndmGi+PAhrRBv9zkzyBcomvfix9A2E61F/+KkArL8QoP
         CClHN1pNEKXVQ==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, arnaud.pouliquen@foss.st.com,
        tangbin@cmss.chinamobile.com, alexandre.torgue@foss.st.com,
        lgirdwood@gmail.com, olivier.moysan@foss.st.com,
        mcoquelin.stm32@gmail.com, perex@perex.cz
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20220525135023.6792-1-tangbin@cmss.chinamobile.com>
References: <20220525135023.6792-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: stm32: sai: Remove useless define
Message-Id: <165459873158.301808.10178152616958894169.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:45:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 21:50:23 +0800, Tang Bin wrote:
> STM_SAI_IS_SUB_B(x) and STM_SAI_BLOCK_NAME(x) are
> not being used, so remove them.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: stm32: sai: Remove useless define
      commit: bf1ebcddcb19a1b6d6d8b75b75626197a5a76d4f

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

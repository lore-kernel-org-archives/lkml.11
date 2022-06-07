Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D6CC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 11:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242320AbiFGLCB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 07:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242017AbiFGK7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:59:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A0A1053E6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:55:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 329B3B81F10
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC235C385A5;
        Tue,  7 Jun 2022 10:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654599303;
        bh=/FaoEG+0isQTgHaNsrpZwMErN2EgRLXLibACJQzoXko=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XC7aFtR2xuV8c4i/UJUsJODwhND2GyFYwwKHGIbHrBM2wMup64mo899gbITct2G5I
         lDhaAjUEVl2as6s9r05rNnISPJzz4acVAHE8qoh1Jd8iNS5k8/q8KKBHkf84eLmdjC
         8fkFpfekTFYUQLmGorOPC141b+ihhXff2gq2XFfiBOs9Nma6b1ywDAWsHutnDi/A7s
         BHEQ2LNopp9v7p8aPGVp5ktdiB+gwnWcwrpGUCsKpIH35TqlCX3XUddrY6ApS5rg85
         6GTntC+V9rbA2qVmxYryks8E4waFVgN5FT4iio6/W/QKjXh7f2+WLeC2rckvNWBUaI
         jGsLN/i2o6PMA==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, tiwai@suse.com, vitalyr@opensource.cirrus.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com
In-Reply-To: <20220525131638.5512-1-vitalyr@opensource.cirrus.com>
References: <20220525131638.5512-1-vitalyr@opensource.cirrus.com>
Subject: Re: (subset) [PATCH v4 00/17] ALSA: hda: cirrus: Add initial DSP support and firmware loading
Message-Id: <165459930242.399031.6035865247693032487.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:55:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 14:16:21 +0100, Vitaly Rodionov wrote:
> The CS35L41 Amplifier contains a DSP, capable of running firmware.
> The firmware can run algorithms such as Speaker Protection, to ensure
> that playback at high gains do not harm the speakers.
> Adding support for CS35L41 firmware into the CS35L41 HDA driver also
> allows us to support several extra features, such as hiberation
> and interrupts.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[09/17] ASoC: cs35l41: Move cs35l41 exit hibernate function into shared code
        commit: 94e0bc317ad241c022a6bb311b3a28b4d51ea8b6
[10/17] ASoC: cs35l41: Do not print error when waking from hibernation
        commit: 97076475e2fdf471348b9ce73215cdbceeb4390f
[11/17] ASoC: cs35l41: Add common cs35l41 enter hibernate function
        commit: e341efc308e5374ded6b471f9e1ec01450bcc93e

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

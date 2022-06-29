Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6399EC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 14:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiF2OoL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 10:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiF2OoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:44:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162FF1EACF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:44:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5ECD61F7B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D60C341C8;
        Wed, 29 Jun 2022 14:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656513847;
        bh=1YEn9fvXA0PLaCeoqu7cVXgKLU0IspUKNzvH94ZGFcA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jIi/PbGgjxbjjmIrmYItwU6UIjRm3l7P9KTz5fa0HFljbhEe50lOtYBiQFeLqg1SC
         MNcUha72VzGtPftRqhlvRiCgZ5bA96J3H8v73Y9+r82lqFT6UHNAyxsbyEh2+WdeU9
         O4rlpUye7jQ2CB7TQHZuvhEPVmJWc4WyD2TH3Gr9rUD6D5a4nm1P7jwSbKM7XfCWBF
         EEtcr7a7lY3B2FCQ6ROdrIdZFfd46/8hXrtbASCnYQ9akEBNgUTjX5vmh7KerEBjoP
         q8Noc92Q0bohMO/ftW6ObCnxBcABp4hDUKOjPAhnWOqvXhJgLqIOeZ6z0wrnMbtHMU
         4t5AwHZSeOBGA==
From:   Mark Brown <broonie@kernel.org>
To:     srinivas.kandagatla@linaro.org
Cc:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220629090644.67982-1-srinivas.kandagatla@linaro.org>
References: <20220629090644.67982-1-srinivas.kandagatla@linaro.org>
Subject: Re: (subset) [PATCH 0/4] ASoC: codecs: add WSA883x support
Message-Id: <165651384559.1635179.5697660258524985288.b4-ty@kernel.org>
Date:   Wed, 29 Jun 2022 15:44:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2022 10:06:40 +0100, Srinivas Kandagatla wrote:
> This patchset adds support for WSA883x smart speaker amplifier codec
> connected via SoundWire. This codec also has a temperature sensor used
> for speaker protection, support for this is not added yet.
> 
> Most of the code is derived from Qualcomm downstream msm-5.10 kernel.
> Thanks to Patrick Lai's Team.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: dt-bindings: Add WSA883x bindings
      commit: 16e2f8a4e9d5e4c7653ee774d9377d602070b16e
[2/4] ASoC: codecs: add wsa883x amplifier support
      commit: 43b8c7dc85a14f36048a27bb6c627fd49144a8d1
[4/4] MAINTAINERS: add ASoC Qualcomm codecs
      commit: a7b028e4252bc1e8b5646657fd45a68792826c23

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

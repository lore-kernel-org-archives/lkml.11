Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1382C25B08
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 14:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbiHQObE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 10:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbiHQObB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:31:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F68201A6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:31:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C726614B7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C42C433D6;
        Wed, 17 Aug 2022 14:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660746659;
        bh=9YvnrLoQeCqNttsLpVzUVSJciSTI41FyiN0F/VdqDIQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=By8RnEImktZUjLmuk6im4iQqRrkQoDYIdt5dGDioSYKZoHCH2aNBSiUCeyCr/oBMJ
         CxucQ5GsnungRHnUIFP9z4vhNCrFRh9nVGBqODwU4AGs0iRqELUU75s7oCyfo7iWTu
         11kec0Lv88dPOEi8KL0FDsPYpdtwOSbr7RpXYb1XClnpaH5xpiCRHBRy6gHD3TG9GH
         dcxF6GpqiZMJ22R+vzLr5L2r/edp2WFh7AiEGMUCYCOMF5uwe2h4E3zhbsxYz5D/X1
         7CUu47VESvDw6q7z5lWbPefWVkGnc1mt9mVCiBHLP0WyLhQyTvU30wcpr/9WfHZm1T
         JELnN8stiI/PA==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, perex@perex.cz, tiwai@suse.com
In-Reply-To: <20220816172129.6661-1-srinivas.kandagatla@linaro.org>
References: <20220816172129.6661-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: core: remove setting platform_max in kcontrol macros
Message-Id: <166074665821.210979.14610893486592798976.b4-ty@kernel.org>
Date:   Wed, 17 Aug 2022 15:30:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 18:21:29 +0100, Srinivas Kandagatla wrote:
> platform_max should not be set by the driver, its intended for machine drivers
> or DT to override the max value for platform specific reasons.
> 
> So remove setting this from Kcontrol macros.
> 
> Setting this to max in these macros would limit the range when min
> value is less then zero.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: core: remove setting platform_max in kcontrol macros
      commit: 26bdcc4ba12351642cd94339aa6996f96434dd47

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

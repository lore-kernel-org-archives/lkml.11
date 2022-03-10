Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E386C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 11:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbiCJLgW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 06:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241626AbiCJLgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:36:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85015142348
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:35:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E3E261585
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724FBC340E9;
        Thu, 10 Mar 2022 11:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646912117;
        bh=qHuRMGS4wNJnueSlJQQpCm5eLSpGCGZ8/lMw/2uIL7g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=D9t13BIJivNlo6iNcy24bXbEPD8ihuA0od8GaW4khcm4weEH+eOA950zEYYOx4YrG
         0YbmLFgWX8+lUnycD2DXH0/MryX0wQdYl4WWp9XOfGWImk/FKLW9/QFgRiM4JE4yE+
         srbRhYLAsn3eWxFqLVwn6KVWUL+7R8QMyozDlzCmAoyZt5gXT48NO/PmqHaqhV9FLJ
         gRn1nV4OenfkzGFz1SNWJqbdmCE6CJzHKH1OHkatioyQkKgp+ijZovhNgoGGFNzchU
         +LYIzfxqVDAZAfXbcphDHOlf2OIYuPLCQOLOLgk0ccwAdu6Z8pL+7pcAL33nPvuAAq
         feAbVZDQM/mfg==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel test robot <lkp@intel.com>, quic_srivasam@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        Randy Dunlap <rdunlap@infradead.org>, lgirdwood@gmail.com
In-Reply-To: <20220309124453.25841-1-srinivas.kandagatla@linaro.org>
References: <20220309124453.25841-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: fix Kconfig for SC7280
Message-Id: <164691211518.13798.17099640461553438579.b4-ty@kernel.org>
Date:   Thu, 10 Mar 2022 11:35:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 12:44:53 +0000, Srinivas Kandagatla wrote:
> select would force the symbol to value without checking the dependencies.
> In this case selecting TX and RX MACROs directly without checking its
> dependency on COMMON_CLK would break builds on platform which do no
> set COMMON_CLK.
> ex:
> WARNING: unmet direct dependencies detected for SND_SOC_LPASS_RX_MACRO
>   Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && COMMON_CLK [=n]
>   Selected by [m]:
>   - SND_SOC_SC7280 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] &&
> 	 SND_SOC_QCOM [=m] && I2C [=y] && SOUNDWIRE [=m]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: fix Kconfig for SC7280
      commit: 31ef579d433a6bcd6b942edea372040298295acf

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

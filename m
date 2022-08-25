Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3972C28D13
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 15:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242840AbiHYP3y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 11:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242812AbiHYP3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:29:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFC3BA9E5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:28:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5A7A61A41
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682F0C433B5;
        Thu, 25 Aug 2022 15:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661441287;
        bh=PcjVIAYMkkfsODQkXxJEf6wliajJqMnE/RTILFVmcFo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=r4z1ZEmg3T1Lhyb4jNf0hMpdVrLftix03K4Mpjw/qzMhpGO64vn9Wo4K4kqptcRjf
         f4tc4vdseBnjYiEcWKeIII38wNT2gqCZaSE1wNTHRog4zr3sC7u+mEL0AaRxTqRROv
         d/UD2hRfdK730jyWI5sqgGnx8+5mUyT/W7+sBlgm5USVgJX9Fd/k4a3Brvl3p3RnCQ
         fEGj4ZeSDYd7dZ5X/X0KUl8hfMNXUdf0NB2PHpM8/EY3DpYJeshh2/xz9YxFb9UgEh
         RPWwaGlFv79fx3KqczejL3LPbA6NfQ0KyUOq0wjU+bztkXpA3L8QkIx6i2vWKnvoHS
         xtT/428jcm62A==
From:   Mark Brown <broonie@kernel.org>
To:     Xiubo.Lee@gmail.com, shengjiu.wang@gmail.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        festevam@gmail.com, shengjiu.wang@nxp.com, perex@perex.cz,
        nicoleotsuka@gmail.com, tiwai@suse.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1661430460-5234-1-git-send-email-shengjiu.wang@nxp.com>
References: <1661430460-5234-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_aud2htx: register platform component before registering cpu dai
Message-Id: <166144128309.526608.9889332004047855940.b4-ty@kernel.org>
Date:   Thu, 25 Aug 2022 16:28:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 20:27:39 +0800, Shengjiu Wang wrote:
> There is no defer probe when adding platform component to
> snd_soc_pcm_runtime(rtd), the code is in snd_soc_add_pcm_runtime()
> 
> snd_soc_register_card()
>   -> snd_soc_bind_card()
>     -> snd_soc_add_pcm_runtime()
>       -> adding cpu dai
>       -> adding codec dai
>       -> adding platform component.
> 
> [...]

Applied to

   broonie/sound.git for-linus

Thanks!

[1/2] ASoC: fsl_aud2htx: register platform component before registering cpu dai
      commit: ea532c29972df96fda20393d9bf057e898f5e965
[2/2] ASoC: fsl_aud2htx: Add error handler for pm_runtime_enable
      commit: b1cd3fd42db7593a2d24c06f1c53b8c886592080

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

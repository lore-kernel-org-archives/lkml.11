Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AC9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 11:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241701AbiCJLgo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 06:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241656AbiCJLge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:36:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52DF14235E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:35:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 607A36164B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D141EC340F5;
        Thu, 10 Mar 2022 11:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646912129;
        bh=EcMTdT2hQETlKPcaxa6tdJVi4CJtSRBE7saSwt/BNyc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IAFk0GHVR1VCBsBTcry8ld6qa71T0UHSYJ8xuZusFRUchqwhQkr6VhZe8KajTUVCu
         XNEokpd0qeI0qQ5kxV5sHYp6R9QFOvMu20cx1fm4LLoWHBbLFkbnwtMJB0L7mjh+/f
         lkSXyuW4yG15avxgMi8cGZGs/pVpIi2D3Kteq/AGHB8/wh//tjAiZt0zAT4LRr8pcz
         LZ+FTtpYg8GWQKGj3zStOgy84dWukOwWK6/PGfuD9EetisLgUH34vOAz0IusQGo+rF
         lW60uvwX/rtvnzpPUvdaL0zuoa5ct7z+D9yWSxuLqfO6WUlq8gGysxS1g4T4+LqMFj
         e/bUN8eJkS33w==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel test robot <lkp@intel.com>, quic_srivasam@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        Randy Dunlap <rdunlap@infradead.org>, lgirdwood@gmail.com
In-Reply-To: <20220309140552.8065-1-srinivas.kandagatla@linaro.org>
References: <20220309140552.8065-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2] ASoC: qcom: fix Kconfig for SC7280
Message-Id: <164691212755.13798.16373159404212027862.b4-ty@kernel.org>
Date:   Thu, 10 Mar 2022 11:35:27 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 14:05:52 +0000, Srinivas Kandagatla wrote:
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

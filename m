Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8352C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 20:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241195AbiF0UTT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 16:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241187AbiF0UTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:19:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD33E1EAEE;
        Mon, 27 Jun 2022 13:19:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C7B4B81ACC;
        Mon, 27 Jun 2022 20:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACA9C385A2;
        Mon, 27 Jun 2022 20:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656361153;
        bh=WuhLwVReyPIuFiHnuKnYYLH+rlvl1fOWMReZYjq2KMA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EzvLipb/md2jDxG97HKhkbVnANDIcXdB9kf1WhKt5pJMqo31/DRMReHEF/yPd0NHq
         lAokPdTX87zAbGK1wokDszHYzYkOgO234P616ZZPoLk+6AfycMhWmdhNC2fauIeoNL
         HLAocQYD/+epH+VC2NbaqYnAkgE+x/rwTVCvMOIqETvkDvPf1ZYSI7p2ASxeLY7wYy
         fPVJUMtPkVpAKYmw8OlVjjSE9PoH9uBYEdH6FLTkPbM9V3AxfUrAEgxRKceaTV2V6y
         7NVCI4a+raTe9wQ0/6dgRWWghZXfAr2//NBeffs6+g9XXMmwzXS7vPiP+l0LC2F56D
         zGX3ZvEa3nNmQ==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, srinivas.kandagatla@linaro.org, perex@perex.cz,
        bgoswami@quicinc.com, lgirdwood@gmail.com,
        yassine.oudjana@gmail.com
Cc:     linux-kernel@vger.kernel.org, y.oudjana@protonmail.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220622061745.35399-1-y.oudjana@protonmail.com>
References: <20220622061745.35399-1-y.oudjana@protonmail.com>
Subject: Re: [PATCH] ASoC: wcd9335: Use int array instead of bitmask for TX mixers
Message-Id: <165636115088.3997797.3429241707337810347.b4-ty@kernel.org>
Date:   Mon, 27 Jun 2022 21:19:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022 10:17:45 +0400, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Currently slim_tx_mixer_get reports all TX mixers as enabled when
> at least one is, due to it reading the entire tx_port_value bitmask
> without testing the specific bit corresponding to a TX port.
> Furthermore, using the same bitmask for all capture DAIs makes
> setting one mixer affect them all. To prevent this, and since
> the SLIM TX muxes effectively only connect to one of the mixers
> at a time, turn tx_port_value into an int array storing the DAI
> index each of the ports is connected to.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wcd9335: Use int array instead of bitmask for TX mixers
      commit: 4b07ef55d1d4178dbec584195be148685ea25c59

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

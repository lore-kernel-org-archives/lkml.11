Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A97C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 20:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239790AbiF0Uqh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 16:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiF0Uqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:46:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D658F19C15;
        Mon, 27 Jun 2022 13:46:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88A84B81B05;
        Mon, 27 Jun 2022 20:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EB0C34115;
        Mon, 27 Jun 2022 20:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656362793;
        bh=UiaAu/L1sfP4Mx0eMmE72X2gzOVHDTEcJcPI7zKKQ2g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CddB4nZT6iM+fjCtSN4kqidyQKt3BmutS2erpTUnZvb76JkBD1onosNbSCWZ5jh8L
         Eq+pzHohiP7IUIwwKfAFBLTiERTPHB7fCtum7nUWUfOl/FwISL2th0E6MZUqRmyIRO
         ndejmvx4meRiHO9NKIZVktYTWaLD8Iy8sz1OjZDfUYe4LWn6JnqTB7Y7s45CzDQ6zj
         IFr6h/jxGNpZ6kXwUh3f7O94BLFDg/8POkGz6I3A4bfGTbRJx80VktD7zfcAkTri+C
         Bdny7eORXbwJx3obunku3cMN2YObFVglah1IDxiNuibajLfRvO+rh4r3IFCnIUKc/M
         SfIhtXS9wuwbg==
From:   Mark Brown <broonie@kernel.org>
To:     jernej.skrabec@gmail.com, lgirdwood@gmail.com, samuel@sholland.org,
        wens@csie.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        perex@perex.cz, arnaud.ferraris@collabora.com,
        devicetree@vger.kernel.org, tiwai@suse.com,
        linux-sunxi@lists.linux.dev, mripard@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20220621035452.60272-1-samuel@sholland.org>
References: <20220621035452.60272-1-samuel@sholland.org>
Subject: Re: (subset) [PATCH v2 0/3] ASoC: sun50i-codec-analog: Internal bias support
Message-Id: <165636279016.4185952.318954133536578049.b4-ty@kernel.org>
Date:   Mon, 27 Jun 2022 21:46:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2022 22:54:49 -0500, Samuel Holland wrote:
> This series adds support for enabling the codec's internal microphone
> bias, which is needed on at least some versions of the PinePhone.
> 
> Changes in v2:
>  - Move register update from component probe to device probe
> 
> Arnaud Ferraris (2):
>   ASoC: dt-bindings: sun50i-codec: Add binding for internal bias
>   ASoC: sun50i-codec-analog: Add support for internal bias
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: sun50i-codec: Add binding for internal bias
      commit: 24e0b04dd42be34ec4b18dc1a1e139d66eb572a3
[2/3] ASoC: sun50i-codec-analog: Add support for internal bias
      commit: 25ae1a04da0d32c22db0b018e5668129b91fa104

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

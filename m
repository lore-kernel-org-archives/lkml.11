Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC42C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 22:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiB1WYk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 17:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiB1WYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:24:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559E2EAC4F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:23:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2BA661314
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD289C340F1;
        Mon, 28 Feb 2022 22:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646087036;
        bh=TE+Rt0fIAbSZ+4U5Y9r3PdSJRY6MPGXc12FuKcxtb6E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qazoUsG6WZM5lo2vUSbvOUqnvQ9hzxrPkVTEwSqrn7QEnoV9eTi9O6q6otat6lwqa
         q4LVw1wObT8OlR4bgSWiZOHZrSX6nX0D+TPqLQt5e1YswLGbeagtM+sAgNx3/Kc54a
         5rYNEy7wRpI62Oh4lT0rBrNe7nvRikqfyxMOkaayBjQx2qIHMysjXrWeHvRk5zy9NF
         wxBldyZ0LDEeTE/97yMVkfLrJr5HpziBIEBlruu1/5eAHdO8EKvZIcygbtcG+8al1X
         Deb/cQpEC89SfpqVlAfzqnXqV1P4U9S4YtgHYeyd5SNMB6POpTyCwRYhJF/ZmUYfNv
         I+4TTMQF7qa3w==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        tiwai@suse.com, perex@perex.cz, linux-kernel@vger.kernel.org,
        quic_srivasam@quicinc.com, lgirdwood@gmail.com
In-Reply-To: <20220228144235.24208-1-srinivas.kandagatla@linaro.org>
References: <20220228144235.24208-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4] ASoC: codecs: wsa881x: add runtime pm support
Message-Id: <164608703449.3143764.5366445148621158953.b4-ty@kernel.org>
Date:   Mon, 28 Feb 2022 22:23:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 14:42:35 +0000, Srinivas Kandagatla wrote:
> WSA SoundWire Controller does not support Clock stop and performs a soft reset
> on suspend  resume path. Its recommended that WSA881x codecs connected to this
> are also reset using a hard reset during suspend resume.
> 
> So this codec driver performs a hard reset during suspend resume cycle.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wsa881x: add runtime pm support
      commit: 8dd55245836119ee3636543b6c2597efd78e643d

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

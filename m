Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFECC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 17:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349212AbiCHRZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 12:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349268AbiCHRW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:22:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEED954BD0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:21:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF060B81BA8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19F2C340EB;
        Tue,  8 Mar 2022 17:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646760047;
        bh=tvhfJPi0JmcP0R6mjk8i1krTBkEIDDxpDLNaiuGZXAg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=A2CddHZy94LgbRB8wjPn4KVlKWYk1NDrVhKp0CIX/+QAwBncvNRbwmdNwaO+WHDZ+
         fdKdOr8DXoDjh6w1EKb7IYzeAvtRsm7Fd+fv/ECFQTCMaKAoIWVnlLed8oh7X32hmz
         YbBZFeXtJ/P9ISZfpeWhaRCQRcl3dDiTUoQYUAa+waYwvX0QQOKBHw4NQCW5kLRJ1n
         NfihRcGXeY9tZI33DudkI+Otibn5UO5QtJASoERVTP3w7dAjVQRUp1epcd6cAN3Gjc
         9BUkoP4b10ghjC0cJ9B6dXZhXdbdebwEDrkiiUy1Jg4v2w4jYRu87BAzyZBl3Zmq/O
         8us52rkdvwiAA==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, perex@perex.cz, tangmeng@uniontech.com,
        YueHaibing <yuehaibing@huawei.com>, lgirdwood@gmail.com,
        Vijendar.Mukunda@amd.com, pierre-louis.bossart@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220305123705.3708-1-yuehaibing@huawei.com>
References: <20220305123705.3708-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] ASoC: amd: acp5x-pcm-dma: Fix signedness bug
Message-Id: <164676004557.54315.464423816098781060.b4-ty@kernel.org>
Date:   Tue, 08 Mar 2022 17:20:45 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Mar 2022 20:37:05 +0800, YueHaibing wrote:
> In acp5x_audio_probe() platform_get_irq() may return error, but i2s_irq now
> is unsigned int so the error handling is never triggered.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp5x-pcm-dma: Fix signedness bug
      commit: 954e615497cc95cd918bdfe6590abdfbaa068842

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

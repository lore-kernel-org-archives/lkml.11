Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D32BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 17:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347984AbiCHRYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 12:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349256AbiCHRW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:22:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC7D546B6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:20:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F9EAB81B8D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007AFC340EF;
        Tue,  8 Mar 2022 17:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646760045;
        bh=A2JRK1Xb/G2itzNwQZPzjojQTUPrqMvKMuhH5+ILS2U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=n1Jofltwu+9VxqUvhulofFMk9/UkknZgQu4CIbkNyXa/webp7A4ylA/zAZddpHUai
         vMZM/25k2S4snDH0iraBV9z8odUyJx2ZIfc17BuTwlaQF8j+jRxE6sch5gfEQJKh43
         B4VaydEJJxGqfeV1vKJqAxZAlasHgOX+tzqXeWKdvA2xKYCnmrs7kDcNuf1nP2OFRC
         Fc89IU3PXKeBB0UbMPFraE1oHKoyIERc9/q12w50tAWUmgjXeSbNI2BjUXf0ZNqnAX
         1Z5QV+0xOV/lzu42NVL1eJFLx+DD+/X/jtdeLa3o6wZCuHwACONOFRxHO47os0IRA6
         qO2vcyp3fLJ8w==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, perex@perex.cz, tangmeng@uniontech.com,
        YueHaibing <yuehaibing@huawei.com>, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220305123613.6324-1-yuehaibing@huawei.com>
References: <20220305123613.6324-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] ASoC: amd: acp3x: Fix signedness bug in acp3x
Message-Id: <164676004367.54315.10724194420698765448.b4-ty@kernel.org>
Date:   Tue, 08 Mar 2022 17:20:43 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Mar 2022 20:36:13 +0800, YueHaibing wrote:
> In acp3x_audio_probe() platform_get_irq() may return error, but i2s_irq now
> is unsigned int so the error handling is never triggered.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp3x: Fix signedness bug in acp3x
      commit: 6f6f28bf5d8e070c1e4a10d62d2a1af264683042

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

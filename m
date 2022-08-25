Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3760C6498F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 15:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242899AbiHYPaI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 11:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241793AbiHYP3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:29:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A69CBB69F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:28:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4793EB82A20
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08990C433D6;
        Thu, 25 Aug 2022 15:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661441305;
        bh=j1fvqVh0D4vhUvOUmY4ADt4O0ZqfHtmTk2qcmFDP/+Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VgnrmywOkzXYfMeKmSFBbO0q6w0W04macSl+owPa1GbecRKvKtWO0tBLOSfxxxDkn
         USj+NZ5CAcEPtIxJftPVw8GCofzFZs2lsfRvmoMRos11yN97DMMCdYOKR8COo0FSSp
         uGMAdl2t0AxIsxC4/aVbo75UGanqiDfw/5+kXzW4b3zepdq0XvyRD2O+WFBJSB3YN2
         QUhHMXfVwlFH3rLBsPRgy/f94NL79B0Ko8guYstxw4Nm82XTDeorKKbW2HI4lwnQNo
         dNThXBMUj/zOGZGzY+SGlH4pjETCY8G0iLDLjyAqsV7+2996e0TD3P3R2Bga6TfTqp
         QoPjawyFOSqRQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, yangyingliang@huawei.com,
        alsa-devel@alsa-project.org
Cc:     lars@metafoo.de, nuno.sa@analog.com, lgirdwood@gmail.com
In-Reply-To: <20220825123525.1845695-1-yangyingliang@huawei.com>
References: <20220825123525.1845695-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] ASoC: sigmadsp: switch to use kmemdup_nul() helper
Message-Id: <166144130241.526663.10391491400558908399.b4-ty@kernel.org>
Date:   Thu, 25 Aug 2022 16:28:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 20:35:25 +0800, Yang Yingliang wrote:
> Use kmemdup_nul() helper instead of open-coding to
> simplify the code.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: sigmadsp: switch to use kmemdup_nul() helper
      commit: 4a34613b2017e89fdf4f63cda65da68b5f50f284

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

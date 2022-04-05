Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19C8C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 15:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387884AbiDEPUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 11:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346818AbiDEJpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:45:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA47F09
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:32:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1521616C1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433DAC385A3;
        Tue,  5 Apr 2022 09:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151120;
        bh=32KftyjLHc+wRCInz68XbmVh1oirhRGgVlh1CMTN5Ew=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=psUKn07cuZDJfOnD3dalSfcruMZLkfwu+O9xmt90SeQHtNaMpsjcfI2aayf5zEZCb
         ffaigjl2HJUNHoza4gORu5FvWKkNKM3/KkLE7QdorP+Akb92/TJN8K8QrUejT2nmAE
         KFzfWdtNzMHU0Kjd6e7T9/euiB41GCKxRDRyDO8wWg4LJIOVUZa+c3FyGaTEelCP0G
         PhRSfr/YL+CKYxc2TYAPH4UTi0VYYS1d3FTdglUZ7EO/J2GNzOCTKm1VrdmsCBRTS3
         Z07Cip77HYRWlhkmsM2USTAmFvat6M6rJk7xOASRPLp4KkK3ZWrExhXuO+t+LhTmGn
         QgpybYwy8eNtg==
From:   Mark Brown <broonie@kernel.org>
To:     rafael@kernel.org, gregkh@linuxfoundation.org,
        rikard.falkeborn@gmail.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220330214110.36337-1-rikard.falkeborn@gmail.com>
References: <20220330214110.36337-1-rikard.falkeborn@gmail.com>
Subject: Re: [PATCH] regmap: Constify static regmap_bus structs
Message-Id: <164915111899.276817.15619096499857459314.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:31:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 23:41:10 +0200, Rikard Falkeborn wrote:
> The only usage of these is to pass their address to __regmap_init() or
> __devm_regmap_init(), both which takes pointers to const struct
> regmap_bus. Make them const to allow the compiler to put them in
> read-only memory.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Constify static regmap_bus structs
      commit: bd941dfaae3503c6b707d8544696205f759e57a3

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

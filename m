Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E28FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Apr 2022 15:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390403AbiDUP57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Apr 2022 11:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390372AbiDUP5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:57:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D5D1C4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:54:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 308A9B826FC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0071EC385A1;
        Thu, 21 Apr 2022 15:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650556492;
        bh=T7XiAVUL8sheYGksXxGj8K3qqxrrGtPhdkaiEqHTACs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hw6L89O6MpP3wzh2EfqLuSEEQUQ3kSKg9s5AIz20lIp4m3r4SFiG6/Q4yIqG9BUlZ
         mxkTiIM70TKbUhbk0djQsGo2IpTXnl3HLEzgabxRjzn8rjgAR956gyGOWR8CCn3Dxb
         NoLa69P0rT1ZfDWXULE7OMt4QLpOfabpnVfsjvkSc95ghl1AqxGc41sb6ln7BbEdPf
         CEptoaPUBp78imbbuSYzq5rTtrEBAV9PE0BU32xbknaxaXygz3C1AN49CCwx6SdqCK
         9ERQxGCt+BdEWTB/I7ewUIvvdo7pvjeR/9uUYCHaEa4xMw94PIsj6GIrnbofk8Twas
         N7X5D5+3K3taQ==
From:   Mark Brown <broonie@kernel.org>
To:     briannorris@chromium.org, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, mka@chromium.org
In-Reply-To: <20220420141511.v2.1.I31ef0014c9597d53722ab513890f839f357fdfb3@changeid>
References: <20220420141511.v2.1.I31ef0014c9597d53722ab513890f839f357fdfb3@changeid>
Subject: Re: [PATCH v2 1/2] regulator: core: Rename _regulator_enable_delay()
Message-Id: <165055649173.364578.18238924275518976830.b4-ty@kernel.org>
Date:   Thu, 21 Apr 2022 16:54:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 14:22:12 -0700, Brian Norris wrote:
> I want to use it in other contexts besides _regulator_do_enable().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: core: Rename _regulator_enable_delay()
      commit: a38dce4cb1f1bcc4f6ef7f11e54b6507a4043ebe
[2/2] regulator: core: Sleep (not delay) in set_voltage()
      commit: 062920d2464715ef5cbba52a8573ba12cc882b8f

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

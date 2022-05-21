Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957F6C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 21 May 2022 04:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbiEUEce (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 May 2022 00:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbiEUEca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 00:32:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88898185433;
        Fri, 20 May 2022 21:32:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2370D60B45;
        Sat, 21 May 2022 04:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFCBC385A5;
        Sat, 21 May 2022 04:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653107548;
        bh=MtA3HwgnwMddgCHNhZRtjdWToZWuCgimnJZfeEUrTv0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YDUfUoL6QncNRpPeKgWoKvgykXAYvpkoUHalIlWo3bBVKYG7fMG6cD0JRPngXgDa7
         uk4UYOU/4laB3Ta09ZW3hEPzLpfNSVMU8FiFndXWqdQtZCauhNcuJVyyrXNWeD4aSB
         lmig8M9z/kdr2c6XXLf38MveBBLHmZKPyua3B/lOQbFew9KElwZV23tMc4BJHy0+2c
         mlWoRkPtLWDpMVEctwevi9BRDajJh7QONVOI27c7yJ1EfjM+W1vzMIYWpl79hf0EWT
         llheKAkpKtRre+W0SGu98aNS/P5DtlRmEfBq61nVDZH/asYsclULkP7vCzP24Qg/yJ
         710Ee0TaVlMIw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <49d726d11964ca0e3757bdb5659e3b3eaa1572b5.1653081643.git.christophe.jaillet@wanadoo.fr>
References: <49d726d11964ca0e3757bdb5659e3b3eaa1572b5.1653081643.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: bcm: rpi: Use correct order for the parameters of devm_kcalloc()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
To:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Date:   Fri, 20 May 2022 21:32:26 -0700
User-Agent: alot/0.10
Message-Id: <20220521043228.7AFCBC385A5@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christophe JAILLET (2022-05-20 14:20:58)
> We should have 'n', then 'size', not the opposite.
> This is harmless because the 2 values are just multiplied, but having
> the correct order silence a (unpublished yet) smatch warning.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next

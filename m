Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B272EC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 May 2022 15:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbiEHPFg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 May 2022 11:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiEHPFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 11:05:33 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BA4DEB8;
        Sun,  8 May 2022 08:01:42 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nniPg-0000sz-KB; Sun, 08 May 2022 17:01:36 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        Sandy Huang <hjc@rock-chips.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH][next] drm/rockchip: Fix spelling mistake "aligened" -> "aligned"
Date:   Sun,  8 May 2022 17:01:33 +0200
Message-Id: <165202207401.1750960.10709503575933689106.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505111044.374174-1-colin.i.king@gmail.com>
References: <20220505111044.374174-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2022 12:10:44 +0100, Colin Ian King wrote:
> There is a spelling mistake in a drm_err message. Fix it.

Applied, thanks!

[1/1] drm/rockchip: Fix spelling mistake "aligened" -> "aligned"
      commit: f0eaf60c67738da8aae786bda74a2fffeca6d7cc

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

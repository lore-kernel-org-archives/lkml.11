Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8DEC43217
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 16:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352438AbiBHQ73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 11:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiBHQ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:59:27 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3017C061576;
        Tue,  8 Feb 2022 08:59:24 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nHTpp-0002ya-Ce; Tue, 08 Feb 2022 17:59:21 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>, linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/2] Add BananaPi R2 Pro board
Date:   Tue,  8 Feb 2022 17:59:16 +0100
Message-Id: <164433936977.231183.11805289547188504542.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123135116.136846-1-linux@fw-web.de>
References: <20220123135116.136846-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jan 2022 14:51:14 +0100, Frank Wunderlich wrote:
> This Series adds RK3568 based Bananapi R2 Board.
> 
> changes in v2:
> - rebase on 5.17-rc1
> - dropped patch for fixing dtbs_check (sent separately)
> - verified pins on gpio-header (con2) and changed pinctrl where needed
> - changed led part
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: rockchip: Add BananaPi R2 Pro Board
[2/2] arm64: dts: rockchip: Add Bananapi R2 Pro

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

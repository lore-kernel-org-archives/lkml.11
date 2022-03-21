Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092B5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 14:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349588AbiCUOSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 10:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349616AbiCUOId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:08:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0CC1E3E4;
        Mon, 21 Mar 2022 07:03:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F2C4611D5;
        Mon, 21 Mar 2022 14:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC9EC340E8;
        Mon, 21 Mar 2022 14:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647871380;
        bh=dja4BpNU5v3FWoo+Pg9KabpZUGDnbBswDF7NRHePqXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jptkxEW4h0u2TKhrm4DSpFa7ruXX+dWtfG8XxBQs6NGhhE3qGJ/EpSj/Y5PWW3e+w
         Cr4qExu4w0oJ/pnAKh17yjBr+h9qfbPSfZuQBWj6HRRzLyZAjxaeYNrLmzQ44lRgOn
         vlcOI0aEzGqAtibDbqCKSsnDk6zJpkI7wLOtG6SA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kurt Cancemi <kurt@x64architecture.com>,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 10/37] net: phy: marvell: Fix invalid comparison in the resume and suspend functions
Date:   Mon, 21 Mar 2022 14:52:52 +0100
Message-Id: <20220321133221.593414150@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321133221.290173884@linuxfoundation.org>
References: <20220321133221.290173884@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kurt Cancemi <kurt@x64architecture.com>

[ Upstream commit 837d9e49402eaf030db55a49f96fc51d73b4b441 ]

This bug resulted in only the current mode being resumed and suspended when
the PHY supported both fiber and copper modes and when the PHY only supported
copper mode the fiber mode would incorrectly be attempted to be resumed and
suspended.

Fixes: 3758be3dc162 ("Marvell phy: add functions to suspend and resume both interfaces: fiber and copper links.")
Signed-off-by: Kurt Cancemi <kurt@x64architecture.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20220312201512.326047-1-kurt@x64architecture.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/marvell.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index cfda625dbea5..4d726ee03ce2 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -1693,8 +1693,8 @@ static int marvell_suspend(struct phy_device *phydev)
 	int err;
 
 	/* Suspend the fiber mode first */
-	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_FIBRE_BIT,
-			       phydev->supported)) {
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_FIBRE_BIT,
+			      phydev->supported)) {
 		err = marvell_set_page(phydev, MII_MARVELL_FIBER_PAGE);
 		if (err < 0)
 			goto error;
@@ -1728,8 +1728,8 @@ static int marvell_resume(struct phy_device *phydev)
 	int err;
 
 	/* Resume the fiber mode first */
-	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_FIBRE_BIT,
-			       phydev->supported)) {
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_FIBRE_BIT,
+			      phydev->supported)) {
 		err = marvell_set_page(phydev, MII_MARVELL_FIBER_PAGE);
 		if (err < 0)
 			goto error;
-- 
2.34.1




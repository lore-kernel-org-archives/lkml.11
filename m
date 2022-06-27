Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F9EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 11:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbiF0LlV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbiF0Lhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:37:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA09222;
        Mon, 27 Jun 2022 04:33:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C7C2608D4;
        Mon, 27 Jun 2022 11:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C31FC3411D;
        Mon, 27 Jun 2022 11:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656329593;
        bh=9EtlxQsMc5ri6HFAXtVDa5cEQKwbR7JyWxgRf83RwYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NkkLh0y+hw9Tp2wS4p0g+1KzuHJ6ydLtHuxG/HZi3G5453r31tZktou/KfqFwfgmI
         WwoQhajXJr58U4QT3LkEtlBxn/ChHNfGjDlj3p9/hDO2PBRY5Fpoww6fkJKstJUuRA
         IxMB0CKBsHk7yflHARSaSGo/E0ybR8zsJ6Zyo0Os=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Toppins <jtoppins@redhat.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 051/135] bonding: ARP monitor spams NETDEV_NOTIFY_PEERS notifiers
Date:   Mon, 27 Jun 2022 13:20:58 +0200
Message-Id: <20220627111939.641048735@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627111938.151743692@linuxfoundation.org>
References: <20220627111938.151743692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jay Vosburgh <jay.vosburgh@canonical.com>

[ Upstream commit 7a9214f3d88cfdb099f3896e102a306b316d8707 ]

The bonding ARP monitor fails to decrement send_peer_notif, the
number of peer notifications (gratuitous ARP or ND) to be sent. This
results in a continuous series of notifications.

Correct this by decrementing the counter for each notification.

Reported-by: Jonathan Toppins <jtoppins@redhat.com>
Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Fixes: b0929915e035 ("bonding: Fix RTNL: assertion failed at net/core/rtnetlink.c for ab arp monitor")
Link: https://lore.kernel.org/netdev/b2fd4147-8f50-bebd-963a-1a3e8d1d9715@redhat.com/
Tested-by: Jonathan Toppins <jtoppins@redhat.com>
Reviewed-by: Jonathan Toppins <jtoppins@redhat.com>
Link: https://lore.kernel.org/r/9400.1655407960@famine
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 2e75b7e8f70b..cd0d7b24f014 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3474,9 +3474,11 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 		if (!rtnl_trylock())
 			return;
 
-		if (should_notify_peers)
+		if (should_notify_peers) {
+			bond->send_peer_notif--;
 			call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
 						 bond->dev);
+		}
 		if (should_notify_rtnl) {
 			bond_slave_state_notify(bond);
 			bond_slave_link_notify(bond);
-- 
2.35.1




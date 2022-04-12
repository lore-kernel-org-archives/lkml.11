Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D95C352A1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 08:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383616AbiDLIhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 04:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356782AbiDLHjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:39:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413A852B05;
        Tue, 12 Apr 2022 00:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AA6FB81B4F;
        Tue, 12 Apr 2022 07:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3015C385A5;
        Tue, 12 Apr 2022 07:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649747405;
        bh=fFmeQeLVr78bZio484MKOB9cuQ1QBglk5UFyOuYQChI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qwY+aVRq2rWCnwB8yjGYA/k2opQ2GfdOGGGlj+Og8KVkDFDMde7kvwrH9pQLxxFGp
         HC3u/3auJqfLSztKzGL9LYZBIJyq954TE37w3Y+r4vWjgRDc4Jt/kQHpEHWuDcXVVq
         48NqXhniDWn4G13UOlYPGFaYz+ZbAw592UPKhGeo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 027/343] Bluetooth: hci_sync: Fix queuing commands when HCI_UNREGISTER is set
Date:   Tue, 12 Apr 2022 08:27:25 +0200
Message-Id: <20220412062951.888710019@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062951.095765152@linuxfoundation.org>
References: <20220412062951.095765152@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 0b94f2651f56b9e4aa5f012b0d7eb57308c773cf ]

hci_cmd_sync_queue shall return an error if HCI_UNREGISTER flag has
been set as that means hci_unregister_dev has been called so it will
likely cause a uaf after the timeout as the hdev will be freed.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sync.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 48c837530a11..8f4c5698913d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -379,6 +379,9 @@ int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 {
 	struct hci_cmd_sync_work_entry *entry;
 
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return -ENODEV;
+
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
 		return -ENOMEM;
-- 
2.35.1




Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8D5C4332F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 09:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbiCGJdB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 04:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237411AbiCGJ2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:28:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003BA6A02D;
        Mon,  7 Mar 2022 01:25:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 66312CE0E99;
        Mon,  7 Mar 2022 09:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C87C340E9;
        Mon,  7 Mar 2022 09:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646645108;
        bh=//8m1zwi+zZ/3sM5PTHTjQJb0lPBjkVWxzhhVEtEb/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dIO6EZxlceVNsfGzMGBWrw92nuToRMe6PqDKXSCb6xXMSh8Y7O2wOTLLtTTx6vicz
         jqCzslXD4CRBSErBaPUtClDbeG4r7l0HtCtDYnkeHO0YQ8MxXWW50tfS5vDxA8FrPI
         Dudge5pR5ezy6ZXcEZc8KfE531nIfDi3PQQjUZng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sukadev Bhattiprolu <sukadev@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 41/51] ibmvnic: free reset-work-item when flushing
Date:   Mon,  7 Mar 2022 10:19:16 +0100
Message-Id: <20220307091638.161249166@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220307091636.988950823@linuxfoundation.org>
References: <20220307091636.988950823@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sukadev Bhattiprolu <sukadev@linux.ibm.com>

commit 8d0657f39f487d904fca713e0bc39c2707382553 upstream.

Fix a tiny memory leak when flushing the reset work queue.

Fixes: 2770a7984db5 ("ibmvnic: Introduce hard reset recovery")
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2100,8 +2100,10 @@ static int ibmvnic_reset(struct ibmvnic_
 	 * flush reset queue and process this reset
 	 */
 	if (adapter->force_reset_recovery && !list_empty(&adapter->rwi_list)) {
-		list_for_each_safe(entry, tmp_entry, &adapter->rwi_list)
+		list_for_each_safe(entry, tmp_entry, &adapter->rwi_list) {
 			list_del(entry);
+			kfree(list_entry(entry, struct ibmvnic_rwi, list));
+		}
 	}
 	rwi->reset_reason = reason;
 	list_add_tail(&rwi->list, &adapter->rwi_list);



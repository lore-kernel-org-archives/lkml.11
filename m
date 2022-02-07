Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD777C43219
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 11:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383429AbiBGLW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 06:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381756AbiBGLRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:17:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEF0C03FEF0;
        Mon,  7 Feb 2022 03:17:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69F06613F8;
        Mon,  7 Feb 2022 11:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFFEC004E1;
        Mon,  7 Feb 2022 11:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644232630;
        bh=2O89AtN1vHXWRPyZpiZKazpXQfHZV1cQsQ/RlhYK4Bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h9qVEwE7/IL0cAaMpvHiXsBsrl2gmHAs3nn6/sCMxVljYV4xP6Xuvc0aQvsW5bze4
         Ij8yys71EyqTvDQHSBBUb8nrfq8rsVVEzukCSk3BkCVkdMNOnNehpWDrDMTI5ixPY2
         ZLjJIEOAxYX6BMZeVEium8QjF6WnyqGGS4XMm0vI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexander Aring <aahringo@redhat.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 4.19 73/86] net: ieee802154: Return meaningful error codes from the netlink helpers
Date:   Mon,  7 Feb 2022 12:06:36 +0100
Message-Id: <20220207103800.069213331@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207103757.550973048@linuxfoundation.org>
References: <20220207103757.550973048@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit 79c37ca73a6e9a33f7b2b7783ba6af07a448c8a9 upstream.

Returning -1 does not indicate anything useful.

Use a standard and meaningful error code instead.

Fixes: a26c5fd7622d ("nl802154: add support for security layer")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Alexander Aring <aahringo@redhat.com>
Link: https://lore.kernel.org/r/20220125121426.848337-6-miquel.raynal@bootlin.com
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ieee802154/nl802154.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1459,7 +1459,7 @@ static int nl802154_send_key(struct sk_b
 
 	hdr = nl802154hdr_put(msg, portid, seq, flags, cmd);
 	if (!hdr)
-		return -1;
+		return -ENOBUFS;
 
 	if (nla_put_u32(msg, NL802154_ATTR_IFINDEX, dev->ifindex))
 		goto nla_put_failure;
@@ -1650,7 +1650,7 @@ static int nl802154_send_device(struct s
 
 	hdr = nl802154hdr_put(msg, portid, seq, flags, cmd);
 	if (!hdr)
-		return -1;
+		return -ENOBUFS;
 
 	if (nla_put_u32(msg, NL802154_ATTR_IFINDEX, dev->ifindex))
 		goto nla_put_failure;
@@ -1828,7 +1828,7 @@ static int nl802154_send_devkey(struct s
 
 	hdr = nl802154hdr_put(msg, portid, seq, flags, cmd);
 	if (!hdr)
-		return -1;
+		return -ENOBUFS;
 
 	if (nla_put_u32(msg, NL802154_ATTR_IFINDEX, dev->ifindex))
 		goto nla_put_failure;
@@ -2005,7 +2005,7 @@ static int nl802154_send_seclevel(struct
 
 	hdr = nl802154hdr_put(msg, portid, seq, flags, cmd);
 	if (!hdr)
-		return -1;
+		return -ENOBUFS;
 
 	if (nla_put_u32(msg, NL802154_ATTR_IFINDEX, dev->ifindex))
 		goto nla_put_failure;



Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3B7C3527B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 11:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382525AbiBGLTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 06:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359284AbiBGLOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:14:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A981C03FEDC;
        Mon,  7 Feb 2022 03:14:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECB216113B;
        Mon,  7 Feb 2022 11:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B7BC004E1;
        Mon,  7 Feb 2022 11:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644232464;
        bh=96vWH8VeJUzwAZTEU3JXtbswkrsSnHsOR4OR7b5bcCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y1YV65qTEMaNYHdKLTLwnHdFnOCkDP4FengGOR31G9nPqTQE48/8zK3xdwD0Hjyew
         /7vK/UyzGI/k2gkTBg6TabJ6jNAt6FkxQ6ZezP7JJT1Hq0snrHXgfn1NJwEXDrC1i2
         cMIjEksiY48AmNu4n67TEgWovB4Q8ITCAQaHS0yo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 18/86] net: sfp: ignore disabled SFP node
Date:   Mon,  7 Feb 2022 12:05:41 +0100
Message-Id: <20220207103758.150313396@linuxfoundation.org>
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

From: Marek Behún <kabel@kernel.org>

commit 2148927e6ed43a1667baf7c2ae3e0e05a44b51a0 upstream.

Commit ce0aa27ff3f6 ("sfp: add sfp-bus to bridge between network devices
and sfp cages") added code which finds SFP bus DT node even if the node
is disabled with status = "disabled". Because of this, when phylink is
created, it ends with non-null .sfp_bus member, even though the SFP
module is not probed (because the node is disabled).

We need to ignore disabled SFP bus node.

Fixes: ce0aa27ff3f6 ("sfp: add sfp-bus to bridge between network devices and sfp cages")
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org # 2203cbf2c8b5 ("net: sfp: move fwnode parsing into sfp-bus layer")
Signed-off-by: David S. Miller <davem@davemloft.net>
[ backport to 4.19 ]
Signed-off-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phylink.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -554,6 +554,11 @@ static int phylink_register_sfp(struct p
 		return ret;
 	}
 
+	if (!fwnode_device_is_available(ref.fwnode)) {
+		fwnode_handle_put(ref.fwnode);
+		return 0;
+	}
+
 	pl->sfp_bus = sfp_register_upstream(ref.fwnode, pl->netdev, pl,
 					    &sfp_phylink_ops);
 	if (!pl->sfp_bus)



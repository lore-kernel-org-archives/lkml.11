Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52284C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 12:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiGEMCD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 08:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiGEMBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:01:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6771838D;
        Tue,  5 Jul 2022 05:01:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B4F9B817D2;
        Tue,  5 Jul 2022 12:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787B2C341C7;
        Tue,  5 Jul 2022 12:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657022463;
        bh=IXuzRz5oVHoJYP8Vq7RjV2ZsHhZp2usTsI+g98gYu2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nz7i5XhjmItYXK8WOFzgitnAeA1YIr72yaJHgnh7BBu7ZJ+axa/Bebu76REQtde/w
         O6FjYEa+2+b8Rd0rnjOMDcdIqPVWjRrhc1pE7eUhJCG3QlIJ151KHela5SYXi444dj
         x1Wq3XQ2kKGAz3otrYo7NQoWdqDFrdKduC0JfjgQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 16/29] NFC: nxp-nci: Dont issue a zero length i2c_master_read()
Date:   Tue,  5 Jul 2022 13:58:04 +0200
Message-Id: <20220705115606.823891248@linuxfoundation.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705115606.333669144@linuxfoundation.org>
References: <20220705115606.333669144@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

commit eddd95b9423946aaacb55cac6a9b2cea8ab944fc upstream.

There are packets which doesn't have a payload. In that case, the second
i2c_master_read() will have a zero length. But because the NFC
controller doesn't have any data left, it will NACK the I2C read and
-ENXIO will be returned. In case there is no payload, just skip the
second i2c master read.

Fixes: 6be88670fc59 ("NFC: nxp-nci_i2c: Add I2C support to NXP NCI driver")
Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nfc/nxp-nci/i2c.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -178,6 +178,9 @@ static int nxp_nci_i2c_nci_read(struct n
 
 	skb_put_data(*skb, (void *)&header, NCI_CTRL_HDR_SIZE);
 
+	if (!header.plen)
+		return 0;
+
 	r = i2c_master_recv(client, skb_put(*skb, header.plen), header.plen);
 	if (r != header.plen) {
 		nfc_err(&client->dev,



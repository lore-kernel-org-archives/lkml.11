Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC38C00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 21:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348250AbiHOVad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 17:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348246AbiHOV1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:27:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3177BE9AB1;
        Mon, 15 Aug 2022 12:23:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8132B60BB7;
        Mon, 15 Aug 2022 19:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85430C433D7;
        Mon, 15 Aug 2022 19:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660591383;
        bh=aZcGBsdZmldfbvVLdPKlPrR+pTlUOeweKXXlUsFE84I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRSem1gtv+6H32Nq2jUiJNdglRzplsJkUWjDmJVNbCdp1c6oZrXfiUn8JDhcx+lDg
         8uicvZGEURyp0wdDUgZqIGDFbbFj7988a0v1zOaWr/FU3Fnh+cWP5KSdnPJGVfcRt0
         7K6SRpAhxVB8XXgC54YMeKUBWOy9VhV3twHHw+kA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 0562/1095] HID: cp2112: prevent a buffer overflow in cp2112_xfer()
Date:   Mon, 15 Aug 2022 19:59:21 +0200
Message-Id: <20220815180452.823221007@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180429.240518113@linuxfoundation.org>
References: <20220815180429.240518113@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

[ Upstream commit 381583845d19cb4bd21c8193449385f3fefa9caf ]

Smatch warnings:
drivers/hid/hid-cp2112.c:793 cp2112_xfer() error: __memcpy()
'data->block[1]' too small (33 vs 255)
drivers/hid/hid-cp2112.c:793 cp2112_xfer() error: __memcpy() 'buf' too
small (64 vs 255)

The 'read_length' variable is provided by 'data->block[0]' which comes
from user and it(read_length) can take a value between 0-255. Add an
upper bound to 'read_length' variable to prevent a buffer overflow in
memcpy().

Fixes: 542134c0375b ("HID: cp2112: Fix I2C_BLOCK_DATA transactions")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-cp2112.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index ece147d1a278..1e16b0fa310d 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -790,6 +790,11 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
 		data->word = le16_to_cpup((__le16 *)buf);
 		break;
 	case I2C_SMBUS_I2C_BLOCK_DATA:
+		if (read_length > I2C_SMBUS_BLOCK_MAX) {
+			ret = -EINVAL;
+			goto power_normal;
+		}
+
 		memcpy(data->block + 1, buf, read_length);
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
-- 
2.35.1




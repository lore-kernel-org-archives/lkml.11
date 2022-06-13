Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5298BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 12:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358294AbiFMMCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 08:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358232AbiFML7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 07:59:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B674EA3C;
        Mon, 13 Jun 2022 03:56:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CD4461257;
        Mon, 13 Jun 2022 10:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6831EC3411E;
        Mon, 13 Jun 2022 10:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655117796;
        bh=gzEyKK8I6JOnFN7klCEewGiQRBGvaWNSnax61KWE0pQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uV/3dWsbxX3FflrFu21xLE/47JwdYUs4xuS889Zo/06P+N8lTykyELRfBmhKA7gGl
         jOGb/XhZqhQAVeSEoz28D798ORAIZ/nqB+5DwVF0Pdyo5CJRoqbAB/Ep9gQsSxK/ew
         DciUQ2/VqlpamY5dP3z1a6IZmfXWfcWEpcaFpWC0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 135/287] i2c: at91: Initialize dma_buf in at91_twi_xfer()
Date:   Mon, 13 Jun 2022 12:09:19 +0200
Message-Id: <20220613094927.973227816@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220613094923.832156175@linuxfoundation.org>
References: <20220613094923.832156175@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit 6977262c2eee111645668fe9e235ef2f5694abf7 ]

Clang warns:

  drivers/i2c/busses/i2c-at91-master.c:707:6: warning: variable 'dma_buf' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
          if (dev->use_dma) {
              ^~~~~~~~~~~~
  drivers/i2c/busses/i2c-at91-master.c:717:27: note: uninitialized use occurs here
          i2c_put_dma_safe_msg_buf(dma_buf, m_start, !ret);
                                   ^~~~~~~

Initialize dma_buf to NULL, as i2c_put_dma_safe_msg_buf() is a no-op
when the first argument is NULL, which will work for the !dev->use_dma
case.

Fixes: 03fbb903c8bf ("i2c: at91: use dma safe buffers")
Link: https://github.com/ClangBuiltLinux/linux/issues/1629
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Michael Walle <michael@walle.cc>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index d5119a2adf5d..29947eb905fb 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -757,7 +757,7 @@ static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
 	unsigned int_addr_flag = 0;
 	struct i2c_msg *m_start = msg;
 	bool is_read;
-	u8 *dma_buf;
+	u8 *dma_buf = NULL;
 
 	dev_dbg(&adap->dev, "at91_xfer: processing %d messages:\n", num);
 
-- 
2.35.1




Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E05C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 20:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352997AbiEQUgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 16:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352978AbiEQUgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:36:38 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00A813D50
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:36:36 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9ABAFC0002;
        Tue, 17 May 2022 20:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652819795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EI7PEHSkI38zkHnnviCUHUxaVjTwrR3jSR8DYXJiRv8=;
        b=VznX2Lo+Yt/7ysaOynEJlVykuwWAF4PCpfkT1YkiciOXMFUMp9yb5Pi3jm0Z1qhb35AO5R
        ftWfhjzAvPvk11vVp5x80N3WoZ77klTkZV+5EUuU8lhvhtShPZOxQAsodH68gePYPd7Nou
        RQzHsb53K/IbRJ6Xg4KYEOywcq7KWplsaCfkjE36EU2lJYhoDtHCN7NfdQlkQ1355JNuD5
        by3QzRijSz0GW6eF8o+kQCphBHEB63UYBnnxkwpDAYiYsyoeUuTewY6jibML2xb81tYca0
        UvT9riwm8ZiuIhE+HTS9OgPZvvc5RWafd3aNcQ0gQrMHtQYs0BRM12zMZvGyfQ==
From:   alexandre.belloni@bootlin.com
To:     linux-i3c@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Guo Zhengkui <guozhengkui@vivo.com>,
        Conor Culhane <conor.culhane@silvaco.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        zhengkui_guo@outlook.com
Subject: Re: [PATCH] i3c: master: svc: fix returnvar.cocci warning
Date:   Tue, 17 May 2022 22:36:32 +0200
Message-Id: <165281969191.286793.10937391190514644254.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220504164901.9622-1-guozhengkui@vivo.com>
References: <20220504164901.9622-1-guozhengkui@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

On Thu, 5 May 2022 00:49:01 +0800, Guo Zhengkui wrote:
> Fix the following coccicheck warning:
> 
> drivers/i3c/master/svc-i3c-master.c:1600:5-8:
> Unneeded variable: "ret". Return "0" on line 1605.
> 
> 

Applied, thanks!

[1/1] i3c: master: svc: fix returnvar.cocci warning
      commit: 227fab1ee7ca70c9b4b0915898e81327aeb70414

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>

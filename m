Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AD3C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Jul 2022 10:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiGIKJG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Jul 2022 06:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiGIKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:07:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E355F4C611;
        Sat,  9 Jul 2022 03:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41B31B819D5;
        Sat,  9 Jul 2022 10:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E55C341CF;
        Sat,  9 Jul 2022 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657361258;
        bh=ibfMihHxqnVqyjSlPywjAGJEXaJu6JD1x0fS1c6kDIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RmkDadC3rUSzWTwxx5nbTbsqHh+GyCpZY7iv/WjYePfGyl40d9c8dMieaMncNp2S4
         +gNMQXXi4nEKXM+gFPIVqgrevCqNcJh5M3ynW7D1x57mQ806TdAGFA8V8FCkop+wjX
         jTCaa5q0ZQJm7e5NAp1MT7Es85zzegxTxhn+7V2tugIfYYVqlTZK1WXWnG7kB/Wv5J
         kpvrDUCP8aSvHifnNCOiSQWZMqpj5Jnud1Nw4PRvp8G+QIik85+7dx1lVtpGfTx6FH
         wH4/JXAkwLyhZXuKf7rolJZtheCIpqXvxeZGcK5KDs2JoU3325qKf5U++aXAX3QpPn
         rJyp61fpedaZA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oA7N9-004EH3-KQ;
        Sat, 09 Jul 2022 11:07:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/21] textsearch: document list inside struct ts_ops
Date:   Sat,  9 Jul 2022 11:07:26 +0100
Message-Id: <04f659c5b604a44f29a42c983b16fb9a8920a1f5.1657360984.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657360984.git.mchehab@kernel.org>
References: <cover.1657360984.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list field of struct ts_ops is not documented:

	include/linux/textsearch.h:51: warning: Function parameter or member 'list' not described in 'ts_ops'

Add a documentation for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/21] at: https://lore.kernel.org/all/cover.1657360984.git.mchehab@kernel.org/

 include/linux/textsearch.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/textsearch.h b/include/linux/textsearch.h
index 6673e4d4ac2e..29de95657ff1 100644
--- a/include/linux/textsearch.h
+++ b/include/linux/textsearch.h
@@ -35,6 +35,7 @@ struct ts_state
  * @get_pattern: return head of pattern
  * @get_pattern_len: return length of pattern
  * @owner: module reference to algorithm
+ * @list: pointer to ts_ops list
  */
 struct ts_ops
 {
-- 
2.36.1


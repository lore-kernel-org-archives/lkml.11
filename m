Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C537DC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 18:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346489AbiFCSEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347272AbiFCRwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:52:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19BC1658C;
        Fri,  3 Jun 2022 10:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72385B823B0;
        Fri,  3 Jun 2022 17:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9F3C385A9;
        Fri,  3 Jun 2022 17:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654278725;
        bh=1SlBnX28+eG2G8boXWkKy1sUzm7l7jBS747wX8oyWIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GADpbnR1oobMdRwb00sTjq5/VX6qn+vfw8mZ37dYG+GDGMlToLrqH7kvuIW9S5tTL
         wVf25bTrTtKJsjejU3k/4197ENnyzmPKGFr7+1E7yLVW8xgX2yh7bIK/Nb2PmWKxdL
         X6r+0ZP5iz7eg4G7Eh61MLCCpVCYyAkyfYQpX3wE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 5.15 43/66] dm crypt: make printing of the key constant-time
Date:   Fri,  3 Jun 2022 19:43:23 +0200
Message-Id: <20220603173821.914690184@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603173820.663747061@linuxfoundation.org>
References: <20220603173820.663747061@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit 567dd8f34560fa221a6343729474536aa7ede4fd upstream.

The device mapper dm-crypt target is using scnprintf("%02x", cc->key[i]) to
report the current key to userspace. However, this is not a constant-time
operation and it may leak information about the key via timing, via cache
access patterns or via the branch predictor.

Change dm-crypt's key printing to use "%c" instead of "%02x". Also
introduce hex2asc() that carefully avoids any branching or memory
accesses when converting a number in the range 0 ... 15 to an ascii
character.

Cc: stable@vger.kernel.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Tested-by: Milan Broz <gmazyland@gmail.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-crypt.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3435,6 +3435,11 @@ static int crypt_map(struct dm_target *t
 	return DM_MAPIO_SUBMITTED;
 }
 
+static char hex2asc(unsigned char c)
+{
+	return c + '0' + ((unsigned)(9 - c) >> 4 & 0x27);
+}
+
 static void crypt_status(struct dm_target *ti, status_type_t type,
 			 unsigned status_flags, char *result, unsigned maxlen)
 {
@@ -3453,9 +3458,12 @@ static void crypt_status(struct dm_targe
 		if (cc->key_size > 0) {
 			if (cc->key_string)
 				DMEMIT(":%u:%s", cc->key_size, cc->key_string);
-			else
-				for (i = 0; i < cc->key_size; i++)
-					DMEMIT("%02x", cc->key[i]);
+			else {
+				for (i = 0; i < cc->key_size; i++) {
+					DMEMIT("%c%c", hex2asc(cc->key[i] >> 4),
+					       hex2asc(cc->key[i] & 0xf));
+				}
+			}
 		} else
 			DMEMIT("-");
 



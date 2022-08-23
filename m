Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC47C49EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 12:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359704AbiHWMGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 08:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359671AbiHWMCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 08:02:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D24DA3D2;
        Tue, 23 Aug 2022 02:36:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A2C061467;
        Tue, 23 Aug 2022 09:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B64DC433D6;
        Tue, 23 Aug 2022 09:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661247379;
        bh=W79uSSvskBaeQttHv1qR+U1nseM67Zgw+Zkr/nhruKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bT1mrr5gbWMKr/WqpscwZ6CyaY3onoFUK8jKK+/P96gXcvFpyy+IhVUVI/F25C9B9
         fgtQgtevBCOM79yVwlhqSsQ3Uo0VFcb4jjhVzK1FglkSdGY5Jbq1EYCC1iB5Ml21te
         ci+M/UjPtX5IEvxudxXSqDxeDJXq+B5teaU8L7ow=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Johansen <john.johansen@canonical.com>
Subject: [PATCH 5.10 018/158] apparmor: fix overlapping attachment computation
Date:   Tue, 23 Aug 2022 10:25:50 +0200
Message-Id: <20220823080046.815234981@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080046.056825146@linuxfoundation.org>
References: <20220823080046.056825146@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Johansen <john.johansen@canonical.com>

commit 2504db207146543736e877241f3b3de005cbe056 upstream.

When finding the profile via patterned attachments, the longest left
match is being set to the static compile time value and not using the
runtime computed value.

Fix this by setting the candidate value to the greater of the
precomputed value or runtime computed value.

Fixes: 21f606610502 ("apparmor: improve overlapping domain attachment resolution")
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/apparmor/domain.c         |    2 +-
 security/apparmor/include/policy.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -465,7 +465,7 @@ restart:
 				 * xattrs, or a longer match
 				 */
 				candidate = profile;
-				candidate_len = profile->xmatch_len;
+				candidate_len = max(count, profile->xmatch_len);
 				candidate_xattrs = ret;
 				conflict = false;
 			}
--- a/security/apparmor/include/policy.h
+++ b/security/apparmor/include/policy.h
@@ -135,7 +135,7 @@ struct aa_profile {
 
 	const char *attach;
 	struct aa_dfa *xmatch;
-	int xmatch_len;
+	unsigned int xmatch_len;
 	enum audit_mode audit;
 	long mode;
 	u32 path_flags;



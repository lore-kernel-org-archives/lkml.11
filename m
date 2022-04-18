Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3522DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 13:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242173AbiDRNSR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 09:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242333AbiDRM7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:59:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA281FCD0;
        Mon, 18 Apr 2022 05:40:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51DF3B80EDB;
        Mon, 18 Apr 2022 12:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F955C385A7;
        Mon, 18 Apr 2022 12:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650285648;
        bh=Ph9hJRhsOem6t2MZ4hC2dNTpwxa/eUuVY6/fsbgX/lU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3+FZ+JH4752/9/dUV5OtQ0O6vplq1MWnFFEB4R9ckw8zkPjnm12wU/lcMV4GAJMu
         0CLp6hmi4DzhMvGb+wUvl39nGVAy7lIFZc7nVGe8jp0vy7Uj0epv7PWT+KJ4WVlv4o
         punMkYCwF0tr7lNN7m2gre4nnDVxh2tyzGA3kc7Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.10 084/105] nl80211: correctly check NL80211_ATTR_REG_ALPHA2 size
Date:   Mon, 18 Apr 2022 14:13:26 +0200
Message-Id: <20220418121149.019557205@linuxfoundation.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220418121145.140991388@linuxfoundation.org>
References: <20220418121145.140991388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

commit 6624bb34b4eb19f715db9908cca00122748765d7 upstream.

We need this to be at least two bytes, so we can access
alpha2[0] and alpha2[1]. It may be three in case some
userspace used NUL-termination since it was NLA_STRING
(and we also push it out with NUL-termination).

Cc: stable@vger.kernel.org
Reported-by: Lee Jones <lee.jones@linaro.org>
Link: https://lore.kernel.org/r/20220411114201.fd4a31f06541.Ie7ff4be2cf348d8cc28ed0d626fc54becf7ea799@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/nl80211.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -475,7 +475,8 @@ static const struct nla_policy nl80211_p
 				   .len = IEEE80211_MAX_MESH_ID_LEN },
 	[NL80211_ATTR_MPATH_NEXT_HOP] = NLA_POLICY_ETH_ADDR_COMPAT,
 
-	[NL80211_ATTR_REG_ALPHA2] = { .type = NLA_STRING, .len = 2 },
+	/* allow 3 for NUL-termination, we used to declare this NLA_STRING */
+	[NL80211_ATTR_REG_ALPHA2] = NLA_POLICY_RANGE(NLA_BINARY, 2, 3),
 	[NL80211_ATTR_REG_RULES] = { .type = NLA_NESTED },
 
 	[NL80211_ATTR_BSS_CTS_PROT] = { .type = NLA_U8 },



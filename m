Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7544AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 12:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiGEMLg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 08:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbiGEMGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:06:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953E623C;
        Tue,  5 Jul 2022 05:05:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40169B817C7;
        Tue,  5 Jul 2022 12:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8153AC341C7;
        Tue,  5 Jul 2022 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657022742;
        bh=FKkgouZZjBPUrb7Wvw9iFLZz7PIMsh/l6Yr1v91nFWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=knpRFNva4k9KybM7dGFn5ScBa210Kb8GxfqrfUlEpssBDqS+EDCpbK4Is9remw3VI
         iH978bKz3KGJ/oLlDrNCBHp9mCEoDko6d7byElvaYW2l7eQHqL+ixUO/5/043JEsCu
         u1Y52IHM/PbEG5dcV0cD6+/rg0/mLQ7lsGt09AQ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jan Beulich <jbeulich@suse.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 5.4 52/58] xen/netfront: fix leaking data in shared pages
Date:   Tue,  5 Jul 2022 13:58:28 +0200
Message-Id: <20220705115611.780976054@linuxfoundation.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705115610.236040773@linuxfoundation.org>
References: <20220705115610.236040773@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Pau Monne <roger.pau@citrix.com>

commit 307c8de2b02344805ebead3440d8feed28f2f010 upstream.

When allocating pages to be used for shared communication with the
backend always zero them, this avoids leaking unintended data present
on the pages.

This is CVE-2022-33740, part of XSA-403.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/xen-netfront.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -261,7 +261,7 @@ static struct sk_buff *xennet_alloc_one_
 	if (unlikely(!skb))
 		return NULL;
 
-	page = alloc_page(GFP_ATOMIC | __GFP_NOWARN);
+	page = alloc_page(GFP_ATOMIC | __GFP_NOWARN | __GFP_ZERO);
 	if (!page) {
 		kfree_skb(skb);
 		return NULL;



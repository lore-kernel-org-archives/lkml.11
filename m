Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFFAC35295
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 14:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351351AbiDNOax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245667AbiDNNit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:38:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4072DA6E3E;
        Thu, 14 Apr 2022 06:33:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D36CA61CF4;
        Thu, 14 Apr 2022 13:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54CFC385AA;
        Thu, 14 Apr 2022 13:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649943217;
        bh=uFktpmXq//VwMEg/Xye+cAieCQG7ieCXEqG53n4shp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lbEWXK+fKWCaTwzpEMrT3McqzFCs73+uOtJ24eDW07jxJ7DL2eZ0ylkJhGTbUN9Jv
         TT06AYiJ7WPSMEZmxdSYx7MRXjx0bcixasnHiIRMqrTnaLGFuDN1zPihYxASvLfv4R
         YDDzRfnGiwfzaZKg0Y7XX6ASfLPV1kqjSSTiIB8g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Dirk=20M=C3=BCller?= <dmueller@suse.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>, Song Liu <song@kernel.org>
Subject: [PATCH 5.4 075/475] lib/raid6/test: fix multiple definition linking error
Date:   Thu, 14 Apr 2022 15:07:40 +0200
Message-Id: <20220414110857.253378136@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110855.141582785@linuxfoundation.org>
References: <20220414110855.141582785@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dirk Müller <dmueller@suse.de>

commit a5359ddd052860bacf957e65fe819c63e974b3a6 upstream.

GCC 10+ defaults to -fno-common, which enforces proper declaration of
external references using "extern". without this change a link would
fail with:

  lib/raid6/test/algos.c:28: multiple definition of `raid6_call';
  lib/raid6/test/test.c:22: first defined here

the pq.h header that is included already includes an extern declaration
so we can just remove the redundant one here.

Cc: <stable@vger.kernel.org>
Signed-off-by: Dirk Müller <dmueller@suse.de>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/raid6/test/test.c |    1 -
 1 file changed, 1 deletion(-)

--- a/lib/raid6/test/test.c
+++ b/lib/raid6/test/test.c
@@ -19,7 +19,6 @@
 #define NDISKS		16	/* Including P and Q */
 
 const char raid6_empty_zero_page[PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
-struct raid6_calls raid6_call;
 
 char *dataptrs[NDISKS];
 char data[NDISKS][PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));



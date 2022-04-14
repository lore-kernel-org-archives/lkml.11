Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A65C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 13:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244139AbiDNNXj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 09:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244047AbiDNNUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:20:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F382954B3;
        Thu, 14 Apr 2022 06:17:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AABF160BAF;
        Thu, 14 Apr 2022 13:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93540C385A5;
        Thu, 14 Apr 2022 13:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649942230;
        bh=LMlQNGlYN3hy8CPToMdfFBPok9Av3xw6NjdEtCImleg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fsyg17GkJAHvf96s7AkRo2t5xlmeEyytNVh+EYXYH12iiRR4AqqJPjMbrRL7wtjsu
         lo7jPibZjRa0fO8E4ZD+lnvkm78DFMEGQEf9meDRi0t5MXN/l0R/FLJrK7gvr4qoNw
         ejBRiF5xftRp9rKqwfYj8qQBEperNAS0vMs3XMHo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Dirk=20M=C3=BCller?= <dmueller@suse.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>, Song Liu <song@kernel.org>
Subject: [PATCH 4.19 060/338] lib/raid6/test: fix multiple definition linking error
Date:   Thu, 14 Apr 2022 15:09:23 +0200
Message-Id: <20220414110840.606123638@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110838.883074566@linuxfoundation.org>
References: <20220414110838.883074566@linuxfoundation.org>
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
@@ -22,7 +22,6 @@
 #define NDISKS		16	/* Including P and Q */
 
 const char raid6_empty_zero_page[PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
-struct raid6_calls raid6_call;
 
 char *dataptrs[NDISKS];
 char data[NDISKS][PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));



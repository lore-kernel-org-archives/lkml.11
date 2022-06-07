Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1C0C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 11:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242362AbiFGLCm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 07:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242807AbiFGLAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:00:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A18B129
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 04:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654599608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=m6bVRDhDwqhXUEbC4cBSqv9R/0i33tbMnIdzh+Mzw68=;
        b=M1p2Anz3gFAuyLtMncmMDO+CgkjK+6AObWLVp3aMXnmt2e/pJoodua1ULXBcbRP5BE9Pwd
        gQ/F9qoY+gXzFajMLndHcS/K7uks9CVMWgFwQDtJTVbvwTH1s4W0TazpOuSJwRF7RXVbPK
        zAbjhlIq3hGvwzugdV573oJBA1lCMEM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-VII4NBxnMO2LXC51gicfMg-1; Tue, 07 Jun 2022 07:00:05 -0400
X-MC-Unique: VII4NBxnMO2LXC51gicfMg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00B1C18A6523;
        Tue,  7 Jun 2022 11:00:05 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-113.pek2.redhat.com [10.72.13.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE4231121315;
        Tue,  7 Jun 2022 11:00:01 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     akpm@linux-foundation.org, urezki@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 0/4] Cleanup patches of vmalloc
Date:   Tue,  7 Jun 2022 18:59:54 +0800
Message-Id: <20220607105958.382076-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cleanup patches found when reading vmalloc code.

v1->v2:
- In Patch 1, Uladzislau suggested a better way to improve code logic,
  and the NOTHING_FIT redundant checking issue naturally goes away.

- Take off the old patch 5 in v1. Instead convert to use generic
  ioremap code in arch codes, then rename the left ioremap_page_range().
  This should be done in later patches. This is suggested by Christoph.

Baoquan He (4):
  mm/vmalloc: invoke classify_va_fit_type() in adjust_va_to_fit_type()
  mm/vmalloc: remove the redundant boundary check
  mm/vmalloc: fix typo in local variable name
  mm/vmalloc: Add code comment for find_vmap_area_exceed_addr()

 mm/vmalloc.c | 46 +++++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

-- 
2.34.1


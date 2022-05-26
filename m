Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F241C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 May 2022 16:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348109AbiEZQG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 12:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244710AbiEZQGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D967E093
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653581180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=dDvOC9kHzg2JKrvyQ+NBfN1SdP3sUV6g6Wnf5nRBBwc=;
        b=PWbJbbRfWKHL/BBs+D3UTrG+doOSxyxY8ZiMKw2od1hTsYwVd/M4SgMo/UjVrcX9dcTPCX
        dmCVNlELnFC9NYKSDWnVKeMnxlcmXHJeq5TB4Mrh62+JykfHVO/yayN/phh0fOxA4aM+gp
        lShwx3zlg5qQYdxMecyqic3rWHuOTxU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-CMkUvEOfPGan6cr0UpucDw-1; Thu, 26 May 2022 12:06:16 -0400
X-MC-Unique: CMkUvEOfPGan6cr0UpucDw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68450296A60A;
        Thu, 26 May 2022 16:06:16 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4552F400F3E8;
        Thu, 26 May 2022 16:06:16 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH v2 0/2] cpuhp: fix some st->target issues
Date:   Thu, 26 May 2022 12:06:13 -0400
Message-Id: <20220526160615.7976-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several small fixes that clean up some cpuhp inconsistencies.
The first prevents target_store() from calling cpu_down() when
target == state which prevents the cpu being incorrectly marked
as dying.  The second just makes the boot cpu have a valid cpuhp 
target rather than 0 (CPU_OFFLINE) while being in state 
CPU_ONLINE.

A further issue which these two patches don't address is that
the cpuX/online file looks at the device->offline state and can
thus get out of sync with the actual cpuhp state if the cpuhp
target is used to change state.


Cheers,
Phil


Phil Auld (2):
  cpuhp: make target_store() a nop when target == state
  cpuhp: Set cpuhp target for boot cpu

 kernel/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.18.0


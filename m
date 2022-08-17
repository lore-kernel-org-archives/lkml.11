Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A447C3F6B0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 09:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbiHQJsu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 05:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiHQJsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:48:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C9513F9A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 02:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660729696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ljRyNyK2441vZHPwQLB8t8h2+qZfvGG/VWTtVtQeGE4=;
        b=i/bU+IZfk84JgPQX2HJ7A7P1PF+kY1N8dmmrIJYTY4/gyTzi92iMqxdmluAjnP3zvvga4k
        u+wByJhv4HDpah5qvv11ZQkNh/VRzBwlMVLtNDsWjEpx5Ma4TWLI2MYat0UfAJx4BLmncq
        m1CKg1HcHUyW9+kgZ7jCO5bKbO3yv14=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-kxTvgst0POqkpBDZzOXFIg-1; Wed, 17 Aug 2022 05:48:15 -0400
X-MC-Unique: kxTvgst0POqkpBDZzOXFIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15631811E80;
        Wed, 17 Aug 2022 09:48:15 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBF2E14582E0;
        Wed, 17 Aug 2022 09:48:14 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+744e173caec2e1627ee0@syzkaller.appspotmail.com,
        Oliver Upton <oliver.upton@linux.dev>,
        David Matlack <dmatlack@google.com>
Subject: Re: [PATCH 0/3] KVM: kvm_create_vm() bug fixes and cleanup
Date:   Wed, 17 Aug 2022 05:47:53 -0400
Message-Id: <20220817094752.1767823-1-pbonzini@redhat.com>
In-Reply-To: <20220816053937.2477106-1-seanjc@google.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks (with the arm/s390 confusion fixed in the last
commit message).

Paolo



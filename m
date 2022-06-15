Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2D5C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 12:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348723AbiFOMOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 08:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348508AbiFOMNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:13:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B865E29E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655295219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=gmOEElJHVWYgJI3o/fAPFhnRJVaPSqPrnZwh78JB8qlKtL4tHVUHCkHpbKWgINqZClfkBx
        1KeAXuxOT+5+SXSAhBaqyXz5xO/Cr7K0VV+o+6BN4+Y8E9nqUfehbeyTuzwZWZU0y27dh6
        PKDkxHjbjBpbqujwhpQooODOigQq5Ns=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-SVunnCgYOQKFSClI1bHyzQ-1; Wed, 15 Jun 2022 08:13:24 -0400
X-MC-Unique: SVunnCgYOQKFSClI1bHyzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7640829DD983;
        Wed, 15 Jun 2022 12:13:13 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40CBE2166B29;
        Wed, 15 Jun 2022 12:13:13 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2] KVM: VMX: Use try_cmpxchg64 in pi_try_set_control
Date:   Wed, 15 Jun 2022 08:13:04 -0400
Message-Id: <20220615121305.1662014-2-pbonzini@redhat.com>
In-Reply-To: <20220520143737.62513-1-ubizjak@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.

Paolo


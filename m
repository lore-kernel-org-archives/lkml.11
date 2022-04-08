Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AF5C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 16:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiDHQsd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 12:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiDHQs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC3B91DA5E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 09:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649436384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=JJTkehx5/u1L0w4TJi697pn4wSkVP9+K3wcLNKciLEHRljRnNALrR2L4xoW6ALPWS7BNV4
        gN80Lsp3J41gGHndwKSzx9SzpduYr33aGRG/DPG5+6K/BvBtnlfFBFZKI5EgShhHxxFyni
        rhSlH3QxU7HoRyfqqT9fG/E3aVAOyT8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-WLlJl6EyNVmDUBmq3OGuEw-1; Fri, 08 Apr 2022 12:46:21 -0400
X-MC-Unique: WLlJl6EyNVmDUBmq3OGuEw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 621E21014A60;
        Fri,  8 Apr 2022 16:46:21 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 406A64066C9A;
        Fri,  8 Apr 2022 16:46:21 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Peng Hao <flyingpenghao@gmail.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  kvm: x86: Adjust the location of pkru_mask of kvm_mmu to reduce memory
Date:   Fri,  8 Apr 2022 12:46:20 -0400
Message-Id: <20220408164620.466539-1-pbonzini@redhat.com>
In-Reply-To: <20220228030749.88353-1-flyingpeng@tencent.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.

Paolo



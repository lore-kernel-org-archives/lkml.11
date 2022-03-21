Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B886AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 08:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345227AbiCUIZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 04:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241261AbiCUIZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2D6713D42
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647851069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KXYbBBC5J0h2TOeYQsMx7cKYoPfbw2MsahWUea49swo=;
        b=NBqbA8LHBJE2BotMoUS+3pm/YEs+wS05e9PHTvJRNDLlShxFJMCqVJwGz75eaoWSp+Fv+2
        f2Y/6Yp7oImXC2tplFiPQMZeiq6G4KLPC6UWv864V9/wBtHWfIQOvRF3iL59XFf/eCJ66n
        oOCMmn7Y6oBhoUHOgXQCV2EkiVfQr7c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-FOAIly8IOuub2Zyflacl4g-1; Mon, 21 Mar 2022 04:24:24 -0400
X-MC-Unique: FOAIly8IOuub2Zyflacl4g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D52785A5A8;
        Mon, 21 Mar 2022 08:24:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 402632026D60;
        Mon, 21 Mar 2022 08:24:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <000000000000b1807c05daad8f98@google.com>
References: <000000000000b1807c05daad8f98@google.com>
To:     syzbot <syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, christophe.jaillet@wanadoo.fr,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in __free_pages
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <970501.1647851062.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 21 Mar 2022 08:24:22 +0000
Message-ID: <970502.1647851062@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be possible to just test for the pointer being NULL in the loop
before calling __free_pages() since the list was allocated with kcalloc().

David

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git 6d39b096627f0a1eb6e14f049d8ae3c93e0290f2


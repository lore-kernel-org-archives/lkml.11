Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1D5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 11:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346721AbiCULVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 07:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiCULVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98D3E80232
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647861605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TXuXLqm5FHH4sp7xPxKCkqjBCYke9wOJKWY6Gs+qP90=;
        b=Yg+wKwcAniMQ2Wfk/rK7If/KwswNdVsYaISt0Jn8UiibZ4d0p1VhUt5g/gyaSB9eiarKr9
        o2Kt9foRwIe/zmIJpgW7DcHDJSx9L2kHTDqrsAEoC1+2aT82OCX4Y3l19D8jCjaFg58O7s
        FS49dnrT6MMM+GecZHCo8xAdId2SBgQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-Czle0zbOMN6q2ddu47c9vQ-1; Mon, 21 Mar 2022 07:20:00 -0400
X-MC-Unique: Czle0zbOMN6q2ddu47c9vQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F087D2A59559;
        Mon, 21 Mar 2022 11:19:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C73FE1410F35;
        Mon, 21 Mar 2022 11:19:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <000000000000b1807c05daad8f98@google.com>
References: <000000000000b1807c05daad8f98@google.com>
To:     syzbot <syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        christophe.jaillet@wanadoo.fr, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in __free_pages
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1003459.1647861598.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 21 Mar 2022 11:19:58 +0000
Message-ID: <1003460.1647861598@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git 	733021c6d8607c5c5ab08bbe9b400d0da609185f


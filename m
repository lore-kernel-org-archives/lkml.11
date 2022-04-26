Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFC8C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 08:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344583AbiDZIXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 04:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344572AbiDZIXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4ACE638193
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650961213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aNhaa4dZuwIsZ3bau/gdwYP34lare5fShqR6oe9C3Es=;
        b=DGvdOV8vBaOlcjy7sIvGds6ivaELNJGoK5J3jooTQItrSkjokA56Njbf8AwtM45RzplvzH
        ggcy7cchWL864/ZPYInvSMBHWxQvWenJPebMcyX2F3Tw095YBIfP4nLqstTOSJ8/F8jcaX
        H/9rXKbj8hQJJ0LE80j5fgHTtfQziDg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-TFfwwowKMQGeuFJuuGYKyw-1; Tue, 26 Apr 2022 04:20:11 -0400
X-MC-Unique: TFfwwowKMQGeuFJuuGYKyw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DAB029ABA02;
        Tue, 26 Apr 2022 08:20:11 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.193.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A5B840D0160;
        Tue, 26 Apr 2022 08:20:09 +0000 (UTC)
Date:   Tue, 26 Apr 2022 10:20:08 +0200
From:   Philipp Rudo <prudo@redhat.com>
To:     lizhe <sensor1010@163.com>
Cc:     "Baoquan He" <bhe@redhat.com>, dyoung@redhat.com,
        vgoyal@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/crash_core.c: No judgment required
Message-ID: <20220426102008.39718e00@rotkaeppchen>
In-Reply-To: <20220426101718.765686a9@rotkaeppchen>
References: <20211210032003.16278-1-sensor1010@163.com>
        <20211214173242.192f47e8@rhtmp>
        <YmX7EW4Gs+c1ZueQ@MiWiFi-R3L-srv>
        <62058381.3b6e.1805f62c8f4.Coremail.sensor1010@163.com>
        <20220426101718.765686a9@rotkaeppchen>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 26 Apr 2022 10:17:18 +0200
Philipp Rudo <prudo@redhat.com> wrote:

> Hi lizhe,
> 
> On Mon, 25 Apr 2022 14:22:31 +0800 (CST)
> lizhe  <sensor1010@163.com> wrote:
> 
> > HI :
> > 
> > 
> > I found the problem at the first time and gave the solution,
> > 
> > 
> > 
> > 
> > Pphilipp Rudo just saw the solution to the problem and gave an explanation.
> > the author of this patch should only be me  
> 
> right, I only commented on the patch you sent.
> 
> Could you please update the commit message and send a v2.


should have checked the rest of my mails first...


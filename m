Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5516DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 18:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244748AbiCBSu1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 13:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbiCBSuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:50:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B658B0E8C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 10:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646246980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LIqgahNWKBFxqAEMAXmZwl+PaaeTRoms/jZ1LE6sQe4=;
        b=RSxkiAU+MMiCJDUljFiF0Jzho6yvLADFAwkp97UyPB04UJrNzxyxZ6UKWP5oK8O6lMBGj3
        XUI046E7EXdP6SCsORd0G3JN84iDTkyOLYob2UPG+trkQ3BDYkTRutb1hPV+rnlZHSF/U6
        GTSuJrcDgWtcFsOkB43VXqqnKkYD7Wo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-ZaipU5mkO42SKSQvedamvw-1; Wed, 02 Mar 2022 13:49:37 -0500
X-MC-Unique: ZaipU5mkO42SKSQvedamvw-1
Received: by mail-lj1-f200.google.com with SMTP id v5-20020a2ea605000000b00246322afc8cso828800ljp.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 10:49:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LIqgahNWKBFxqAEMAXmZwl+PaaeTRoms/jZ1LE6sQe4=;
        b=Q+Iy8Ypz1hzLEOBdUxbM8xnwLTyI0LdXQf9SW4f5Tz33OcPe/Wvv69hDdrW51o3uxw
         cZMn07kG+tZ7v6E69dbrDuf2kdMmDKQFcLZWITdAEPdh3opiSbGA3oy7OW38X2tCT798
         DIdNUUXfW17d5LrclzRCktgekkJxgaumlHvfmQwKZ9HMjopxtBcNPLHF/l4n7xTv0ghv
         IypBxayaac2eUfaLdc+sPXDqGDhXMKdC1z9zhqKbKJKCLIKpTSGi7n115agovbamN5yp
         gpgBi1KufRoExrNnalleJcsAKXfVf32tJu4k3yNravUzV6O+bmBGumeie3J9yCDYDBNf
         qsdQ==
X-Gm-Message-State: AOAM530s/ZRRSX8XCOVdS4iepXh7Ysixy/9Et6EDgiyC6M3Mac/jWXWX
        0cv9egWuH0jCJJ3/rEXsWRfR47sQVLAARse2wphiKopH5wDJ6hrMoqR2DwcwK2tAQ1T0fmrrcTQ
        1jIlo0mpRx/+8Gl9kCXStokPIpSGzQzPMbMinJqje
X-Received: by 2002:a2e:b0fb:0:b0:245:f4a9:3b5 with SMTP id h27-20020a2eb0fb000000b00245f4a903b5mr22018437ljl.92.1646246975780;
        Wed, 02 Mar 2022 10:49:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLI9Xtv8VVJRyoM8xP1vr/fEEcNyaG/k8jSqHBEy3b8mc2kotblpgoKshBbshYQGFcAx0aUenO7GaBIImvT3U=
X-Received: by 2002:a2e:b0fb:0:b0:245:f4a9:3b5 with SMTP id
 h27-20020a2eb0fb000000b00245f4a903b5mr22018430ljl.92.1646246975603; Wed, 02
 Mar 2022 10:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20220224230035.36547137@gandalf.local.home> <Yhhh730RX1HpdXp2@google.com>
 <Yhhj9MLZTrhjSWUE@google.com> <20220225083209.24bafe2c@gandalf.local.home>
 <20220225084256.071dcf82@gandalf.local.home> <YhmOifZcbbxVHPr9@google.com>
 <CAAq0SUkUAMyCoLt=n9X7+QH93zZ00ZpXNjG-gv7xUzL3YGtaPQ@mail.gmail.com> <20220228110559.2a8e0b32@gandalf.local.home>
In-Reply-To: <20220228110559.2a8e0b32@gandalf.local.home>
From:   Wander Costa <wcosta@redhat.com>
Date:   Wed, 2 Mar 2022 15:49:24 -0300
Message-ID: <CAAq0SU=Ydb6_85jLADLbc7E1XuoEgGLMmQG1pXduEyBu5awApA@mail.gmail.com>
Subject: Re: Strange output on the console
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Willy Tarreau <w@1wt.eu>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 1:11 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sat, 26 Feb 2022 08:49:45 -0300
> Wander Costa <wcosta@redhat.com> wrote:
>

[snip]

>
> Anything else I could do to find out more?
>

I think I have everything I need, thank you.


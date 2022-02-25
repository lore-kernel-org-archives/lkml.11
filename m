Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D37EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 06:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237484AbiBYGNN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 01:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiBYGNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:13:12 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C1EA172E5E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 22:12:40 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-147-A1-nNgw5OU26roG4mbNyRw-1; Fri, 25 Feb 2022 06:12:37 +0000
X-MC-Unique: A1-nNgw5OU26roG4mbNyRw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 25 Feb 2022 06:12:35 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 25 Feb 2022 06:12:35 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: RE: Strange output on the console
Thread-Topic: Strange output on the console
Thread-Index: AQHYKfxF0QTTTto/+k+8VsyEcwRQo6yjyM1g
Date:   Fri, 25 Feb 2022 06:12:35 +0000
Message-ID: <61226fc12ff9459d8daed8e346d6ab94@AcuMS.aculab.com>
References: <20220224230035.36547137@gandalf.local.home>
In-Reply-To: <20220224230035.36547137@gandalf.local.home>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt
> Sent: 25 February 2022 04:01
> 
> I've been noticing that my tests have been spitting out strange output on
> the console. It would happen at boot up and then clear up. It looks like
> something screwed up with the serial timing.
> 
> Attached is a dmesg of one of my test runs as an example.
> 
> I've noticed this on both 32 bit and 64 bit x86.
> 
> I haven't had time to look deeper into this, but I figured I let you know
> about it.
> 
> And it always seems to happen right after:
> 
>   Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> 
> Maybe this is a serial issue and not a printk one? :-/

Looks very much like the serial baud rate is being reset.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


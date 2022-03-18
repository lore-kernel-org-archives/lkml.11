Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16840C4332F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 15:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbiCRPXp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 11:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbiCRPXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:23:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D39B262411
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:22:23 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-150-J-EB7TRUPCa955UakG2Ikg-1; Fri, 18 Mar 2022 15:22:20 +0000
X-MC-Unique: J-EB7TRUPCa955UakG2Ikg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Fri, 18 Mar 2022 15:22:20 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Fri, 18 Mar 2022 15:22:20 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Juergen Gross' <jgross@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Dell.Client.Kernel@dell.com" <Dell.Client.Kernel@dell.com>
CC:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] platform/x86/dell: add buffer allocation/free functions
 for SMI calls
Thread-Topic: [PATCH] platform/x86/dell: add buffer allocation/free functions
 for SMI calls
Thread-Index: AQHYOto/hyLOp/NEJ0S+JLWvPC30KazFQPKg
Date:   Fri, 18 Mar 2022 15:22:19 +0000
Message-ID: <accf95548a8c4374b17c159b9b2d0098@AcuMS.aculab.com>
References: <20220318150950.16843-1-jgross@suse.com>
In-Reply-To: <20220318150950.16843-1-jgross@suse.com>
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

From: Juergen Gross
> Sent: 18 March 2022 15:10
> 
> The dcdbas driver is used to call SMI handlers for both, dcdbas and
> dell-smbios-smm. Both drivers allocate a buffer for communicating
> with the SMI handler. The physical buffer address is then passed to
> the called SMI handler via %ebx.
> 
> Unfortunately this doesn't work when running in Xen dom0, as the
> physical address obtained via virt_to_phys() is only a guest physical
> address, and not a machine physical address as needed by SMI.

The physical address from virt_to_phy() is always wrong.
That is the physical address the cpu has for the memory.
What you want is the address the dma master interface needs to use.
That can be different for a physical system - no need for virtualisation.

On x86 they do usually match, but anything with a full iommu
will need completely different addresses.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


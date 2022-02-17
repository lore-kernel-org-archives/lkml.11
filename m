Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5864AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 05:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiBQFKx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 00:10:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiBQFKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 00:10:52 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9A79F2A5983;
        Wed, 16 Feb 2022 21:10:35 -0800 (PST)
Received: by ajax-webmail-mail-app3 (Coremail) ; Thu, 17 Feb 2022 13:10:17
 +0800 (GMT+08:00)
X-Originating-IP: [180.169.129.130]
Date:   Thu, 17 Feb 2022 13:10:17 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jing Leng" <3090101217@zju.edu.cn>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, pavel.hofman@ivitera.com,
        ruslan.bilovol@gmail.com, "Jing Leng" <jleng@ambarella.com>
Subject: Re: Re: [PATCH v3] usb: gadget: f_uac1: add different speed
 transfers support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <YgzUJhcFk1FAKfJV@kroah.com>
References: <YgprpGbtBpojsCmQ@kroah.com>
 <20220215030848.5709-1-3090101217@zju.edu.cn> <Yguz4hOBYTXRL35t@kroah.com>
 <13396706.ae161.17f005864cf.Coremail.3090101217@zju.edu.cn>
 <YgzUJhcFk1FAKfJV@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <649b6b8a.a6d4b.17f06169537.Coremail.3090101217@zju.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: cC_KCgBHR2y52A1ix79kDQ--.23262W
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwIEBVNG3FjlrQACsb
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZyBLSCwKClNvcnJ5IGZvciB0aGUgY29uZnVzaW9uLgoKSSB1bmRlcnN0YW5kIHdoYXQg
eW91IG1lYW4gKFN0YXRpYyB2YXJpYWJsZXMgZG8gbm90IG5lZWQgdG8KIGJlIGV4cGxpY2l0bHkg
aW5pdGlhbGl6ZWQgdG8gMCkuCkkgd2lsbCBtb2RpZnkgdGhlIHBhdGNoLCBhZGQgdGhlIGNoYW5n
ZSBsb2cgYW5kIHJlc2VuZCBpdC4KClRoYW5rcywKSmluZyBMZW5nCg==

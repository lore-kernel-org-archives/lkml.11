Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA525C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 16:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350604AbiCUQDu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 12:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348726AbiCUQDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:03:48 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CACD53A70
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:02:23 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-31-F6hM2S3-NnqEGYc8T09CnQ-1; Mon, 21 Mar 2022 16:02:20 +0000
X-MC-Unique: F6hM2S3-NnqEGYc8T09CnQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Mon, 21 Mar 2022 16:02:20 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Mon, 21 Mar 2022 16:02:20 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Wan Jiabing' <wanjiabing@vivo.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "alexandr.lobakin@intel.com" <alexandr.lobakin@intel.com>
Subject: RE: [PATCH v2] ice: use min_t() to make code cleaner in ice_gnss
Thread-Topic: [PATCH v2] ice: use min_t() to make code cleaner in ice_gnss
Thread-Index: AQHYPSxszwX/VYzTWUmJ1ZXJKTtOx6zJ/3tw
Date:   Mon, 21 Mar 2022 16:02:20 +0000
Message-ID: <f888e3cf09944f9aa63532c9f59e69fb@AcuMS.aculab.com>
References: <20220321135947.378250-1-wanjiabing@vivo.com>
In-Reply-To: <20220321135947.378250-1-wanjiabing@vivo.com>
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

From: Wan Jiabing
> Sent: 21 March 2022 14:00
> 
> Fix the following coccicheck warning:
> ./drivers/net/ethernet/intel/ice/ice_gnss.c:79:26-27: WARNING opportunity for min()
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
> Changelog:
> v2:
> - Use typeof(bytes_left) instead of u8.
> ---
>  drivers/net/ethernet/intel/ice/ice_gnss.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
> index 35579cf4283f..57586a2e6dec 100644
> --- a/drivers/net/ethernet/intel/ice/ice_gnss.c
> +++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
> @@ -76,8 +76,7 @@ static void ice_gnss_read(struct kthread_work *work)
>  	for (i = 0; i < data_len; i += bytes_read) {
>  		u16 bytes_left = data_len - i;

Oh FFS why is that u16?
Don't do arithmetic on anything smaller than 'int'

	David

> 
> -		bytes_read = bytes_left < ICE_MAX_I2C_DATA_SIZE ? bytes_left :
> -					  ICE_MAX_I2C_DATA_SIZE;
> +		bytes_read = min_t(typeof(bytes_left), bytes_left, ICE_MAX_I2C_DATA_SIZE);
> 
>  		err = ice_aq_read_i2c(hw, link_topo, ICE_GNSS_UBX_I2C_BUS_ADDR,
>  				      cpu_to_le16(ICE_GNSS_UBX_EMPTY_DATA),
> --
> 2.35.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


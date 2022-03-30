Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3507C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 01:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241543AbiC3BQs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 21:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiC3BQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 21:16:44 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531D443488
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 18:14:57 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 30 Mar
 2022 09:14:57 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 30 Mar
 2022 09:14:55 +0800
Message-ID: <ce82792a-9e9e-f324-641e-d1fbcb26b1a0@meizu.com>
Date:   Wed, 30 Mar 2022 09:14:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3] staging: r8188eu: Directly return _SUCCESS instead of
 using local ret variable
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <1648551967-23627-1-git-send-email-baihaowen@meizu.com>
 <1648552158-24203-1-git-send-email-baihaowen@meizu.com>
 <20220329112844.GB3293@kadam>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <20220329112844.GB3293@kadam>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-125.meizu.com (172.16.1.125) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 3/29/22 7:28 PM, Dan Carpenter 写道:
> On Tue, Mar 29, 2022 at 07:09:17PM +0800, Haowen Bai wrote:
>> @@ -534,9 +531,6 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
>>  free_mlme_ext:
>>  	free_mlme_ext_priv(&padapter->mlmeextpriv);
>>  
>> -free_mlme_priv:
>> -	rtw_free_mlme_priv(&padapter->mlmepriv);
> Nope.  We still need to free this on the error path.  Just delete the
> unused label but don't delete the free function.
>
>> -
>>  free_evt_priv:
>>  	rtw_free_evt_priv(&padapter->evtpriv);
> regards,
> dan carpenter
yes, you are right. It will lead to memory leak.

-- 
Haowen Bai


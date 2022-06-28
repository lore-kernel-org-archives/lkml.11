Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09692C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 08:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245456AbiF1Iih (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 04:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344257AbiF1IiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:38:13 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD6E39F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:38:12 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id r18so8614386edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p6k9PAUGs1z+JQ0fp9zJbrOIxdGLr6+feq4PW23Em44=;
        b=wqvzKGgDVWcxEbh/XlZDO28lM4QcPStqux2QSLQGppBXktNm3IQ6jqd4kOLjO7Ybxt
         O7g6WhMImOLfFSnMzTYcXUznlKewTqTIw96SZATPsHPEItX6kLtJhif4CbEeWhm2DifP
         Ya5ukEGtDg+QnSzlDdoXbr9tGu5VwcLPNW8i3KLn5dRe0lTap1iyf1o2xtzQmF5cLzy+
         YQH43DXRqDLyjNXQtPdOUTX1UsO6pgi9qKN/8LCDGmWZltfik6c1IbJ/pqEDq4NhEMxs
         8yUmx1pPc8c5D5ZUIfSjecfLae0qTTNN+hnd8jbtzg9yLmBCuUPZbMp4TNof374L7PI7
         xSXQ==
X-Gm-Message-State: AJIora9iYbrT1VbeVeF3XmNGZyC9v0S9ix+NUpwQA8qQgYaq8a5unvzv
        k+pmbdsE44+SpPcRbzvrN+s=
X-Google-Smtp-Source: AGRyM1u9yl1IHnbEm7mXuk72tlHurn7VsFWFFq6+bozDJ2jvISyBMpAM1zupNCTvGl1Qb3DpALY1kw==
X-Received: by 2002:a05:6402:27cf:b0:435:dae6:26aa with SMTP id c15-20020a05640227cf00b00435dae626aamr21523064ede.323.1656405490615;
        Tue, 28 Jun 2022 01:38:10 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906698a00b0071cbc7487e0sm6163445ejr.71.2022.06.28.01.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 01:38:10 -0700 (PDT)
Message-ID: <466232ee-8d55-e33f-d2ca-e6b9fc0b8103@kernel.org>
Date:   Tue, 28 Jun 2022 10:38:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] vt: fix memory overlapping when deleting chars in the
 buffer
Content-Language: en-US
To:     Yangxi Xiang <xyangxi5@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        nick black <dankamongmen@gmail.com>
References: <10b4e5f7-95b9-38e6-bcd5-1132d595301c@kernel.org>
 <20220628082740.4685-1-xyangxi5@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220628082740.4685-1-xyangxi5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28. 06. 22, 10:27, Yangxi Xiang wrote:
>> Why not to use memmove in both cases? I.e. simply switch scr_memcpyw to
>> scr_memmovew?
> 
> Both of them works, and I pick one of them.

Sorry, I don't understand.

-- 
js
suse labs

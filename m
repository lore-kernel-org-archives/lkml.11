Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51CEC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 May 2022 02:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344983AbiEZCBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 22:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiEZCBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:01:33 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DDBC16
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 19:01:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id bo5so531941pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 19:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5s8OTVC0kafHJHgEph/R+vmdkh8uWtsTbNCWxcRtHvY=;
        b=4yPOdpC4yWSLjujL3zf8AjL/z5oVxgXKaTPQ3ax//xitmsL4B6HpkVVrnobiz2HhDk
         vxTgzgaSUr7DnLx+TiVLTinlwm+C9cTVbYo4dkdk6QwO0cacZ0a5O3bDlRdVaxyOF4Th
         cXEdEG5dm465SuNw7uTKXa3By5LNdwD6SjWlQjS/X+sN7d35ydAtOZDwwsPog+xUcALl
         j5TQQUel6IWSEu9OQV5wRcH/sxhtczhIoRjE6pc7kFU+VZH7rIWNdeGndhervL5/R0Hb
         SyrTgrcX3qhdZXmAyEcW0S8NYYyrSgRr+yjg8GS/olwo9UJBe2FzSP0LvqG5y7MzG7d9
         VMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5s8OTVC0kafHJHgEph/R+vmdkh8uWtsTbNCWxcRtHvY=;
        b=fwZbO1ps/mZPeY4kFrsnW4lNducJXDI6SfSyblo+jiyO/d1VfRmdn3Pmk+H/HWF1xz
         kdQDRkyLBIMWlBQNxaYnskjO+NZwgQ4nCTEn8V+lMp/nQbA8oT2GZTFbI3//7oXe8DBD
         wY1mlaze10+tdDY5vgswuDuVCMKjIT2EevZ+B2qaiN9tAU2t4kSGb6Nq1ndAWlgDcETW
         PHlMw+TCJ5P16O7QxzLY6014w1i9G/SqK2gPl6uOX6x0HwKnGmq3LMBZmZEoy9MmGzIX
         2zlrLCVhsrnc8jH26vMpqasRP8hHF84XyjPvASEN+7VIKn7xAsqpebQX7RpDwuEHUol3
         z75Q==
X-Gm-Message-State: AOAM5321Pf5P+/NEno57AHC9Lpux3phyInY88WDBLBbLJx2a0XHJubJa
        QEm2bYQ6FbjjsNsuVwYKVrLVVXhwdXO35g==
X-Google-Smtp-Source: ABdhPJxZZEe0rA+BamSvT+doNR0V65qDcP+mGkOqhXQreoHYklsOrzPJvoI06F3tCXLeH/M3lw3X8Q==
X-Received: by 2002:a65:4c44:0:b0:39c:e0b5:cd2a with SMTP id l4-20020a654c44000000b0039ce0b5cd2amr31071478pgr.481.1653530489877;
        Wed, 25 May 2022 19:01:29 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40c:3e14:bb57:48be])
        by smtp.gmail.com with ESMTPSA id d5-20020aa78685000000b0050dc76281e6sm47896pfo.192.2022.05.25.19.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 19:01:29 -0700 (PDT)
Date:   Thu, 26 May 2022 10:01:25 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v4 4/6] mm: docs: document shrinker debugfs
Message-ID: <Yo7fdcvPvwhEeo3T@FVFYT0MHHV2J.googleapis.com>
References: <20220525202600.2910982-1-roman.gushchin@linux.dev>
 <20220525202600.2910982-5-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525202600.2910982-5-roman.gushchin@linux.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 01:25:58PM -0700, Roman Gushchin wrote:
> Add a document describing the shrinker debugfs interface.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12901C4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352658AbiBUJrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:47:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350943AbiBUJkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:40:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FF123CA55
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645435028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4uMmEYUHbmX6rXgTsQ+VTDhgS4w4FUz1dvxMDB4NcL4=;
        b=bwiUSjS5Zx+VGAAfYH2G/S0bATuthWZq1rXuATKU7mhhnPRNo1UJtaT5cLufyoKtdqBldp
        ZeumfIoQyKnssYtuxUYlIqKtBCki1+yIpMZ2H45m1yf69H8vchjS5x+PCRre+/fjl7hBFk
        sU/5GEZUOmANx+gy3dxnHW+/K2YYgLI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-9uqGIGHHPvqPUMe9CnyZZQ-1; Mon, 21 Feb 2022 04:17:07 -0500
X-MC-Unique: 9uqGIGHHPvqPUMe9CnyZZQ-1
Received: by mail-ed1-f70.google.com with SMTP id bq19-20020a056402215300b0040f276105a4so9813643edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4uMmEYUHbmX6rXgTsQ+VTDhgS4w4FUz1dvxMDB4NcL4=;
        b=EZQ3UWw9WVZs6khpZn0LdgZ/njD3ZK8NSxjr6H+bWQb+VNlNlEQweFokmyriYFVx3U
         ewx5wQn0azKaRxP/xUn7GRKw9f8tKPBNrMMGXNPV3o93fFL9XL0Jpd1rqZuIkjCQWcaW
         hkFzx7DBbeLZBPpDDMnA20oH7XgAa8usRjo2RZG4zcv31InVG+nYFHax051aHxpEDLmi
         yZNbToVMlA/DXyYkgghwNZ8tIJICDpqW7cM6SRE5yGcgXLBof74Ea9kDoMNhAq5zoGTz
         YSawsZXMFVRm3yx7dIGIyGiSfKIkmeXDKgMEfcKDH5lDWp3v3zmhxHmxodPLtsHV6eXZ
         gqmQ==
X-Gm-Message-State: AOAM532yIWs9uFwvmXOB5NdcpmrSkR8Z0u7Q8SctG0gNGRniDS3pWXud
        UQmFXJO+gtPWwPOKMs1RGrNk58OPObSqzCkEevUw5SSelsUlfF3K2MUxSVNe651yJv2YhNpTs2G
        oZoPsvTwPeJ2If1Q3OpA6XwRt
X-Received: by 2002:a50:aac8:0:b0:410:ae77:c484 with SMTP id r8-20020a50aac8000000b00410ae77c484mr19984678edc.431.1645435025887;
        Mon, 21 Feb 2022 01:17:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBpEa0p3HrEYx+GIqbhwJ9nin5147rOk0KhJ0pTriV1JShySKOfRZ5XC7JzVwzygFMagfvqw==
X-Received: by 2002:a50:aac8:0:b0:410:ae77:c484 with SMTP id r8-20020a50aac8000000b00410ae77c484mr19984657edc.431.1645435025651;
        Mon, 21 Feb 2022 01:17:05 -0800 (PST)
Received: from redhat.com ([2.52.4.205])
        by smtp.gmail.com with ESMTPSA id v23sm5048559ejy.177.2022.02.21.01.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 01:17:05 -0800 (PST)
Date:   Mon, 21 Feb 2022 04:17:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
Message-ID: <20220221041626-mutt-send-email-mst@kernel.org>
References: <20220221040745.1177-1-hdanton@sina.com>
 <20220221085227.1356-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221085227.1356-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 04:52:27PM +0800, Hillf Danton wrote:
> Another round of attempts to quiesce the
> WARNING: CPU: 1 PID: 4069 at drivers/vhost/vhost.c:715 after the
> BUG at drivers/vhost/vhost.c:2337 went home.

Could you pls clarify what do you mean by "went home" here?

Thanks,

-- 
MST

